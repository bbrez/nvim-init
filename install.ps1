<#
.SYNOPSIS
  Hardened Neovim config installer for PowerShell.

.DESCRIPTION
  Mirrors the Bash implementation with:
  - Strict mode and fail-fast behavior
  - XDG/LOCALAPPDATA-aware defaults
  - Parameters: -Yes, -DryRun, -Source, -Target
  - Safe deletes (remove only children, not the directory itself)
  - Robust copy including hidden items
  - Clear confirmation and logging

.EXAMPLE
  .\install.ps1

.EXAMPLE
  .\install.ps1 -DryRun

.EXAMPLE
  .\install.ps1 -Yes -Source . -Target "$env:LOCALAPPDATA\nvim"

.NOTES
  Requires PowerShell 7+ for best compatibility.
#>

[CmdletBinding(PositionalBinding = $false)]
param(
  [switch]$Yes,
  [switch]$DryRun,

  # Directory to copy from. Defaults to the script's folder.
  [string]$Source = $PSScriptRoot,

  # Destination directory. Defaults to:
  #   - $env:XDG_CONFIG_HOME\nvim, or
  #   - $env:LOCALAPPDATA\nvim, or
  #   - $HOME\.config\nvim
  [string]$Target
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ----------------------- Logging helpers -----------------------

function Write-Info {
  param([Parameter(Mandatory)][string]$Message)
  Write-Host $Message
}

function Write-Warn {
  param([Parameter(Mandatory)][string]$Message)
  Write-Warning $Message
}

function Throw-Error {
  param([Parameter(Mandatory)][string]$Message)
  throw $Message
}

# ----------------------- Path helpers --------------------------

function Resolve-AbsolutePath {
  param([Parameter(Mandatory)][string]$Path)

  if ([string]::IsNullOrWhiteSpace($Path)) {
    Throw-Error "Empty path provided."
  }

  # Expand ~ for user home
  if ($Path.StartsWith('~')) {
    $Path = $Path -replace '^~', $HOME
  }

  try {
    $item = Get-Item -LiteralPath $Path -ErrorAction Stop
    return $item.FullName
  }
  catch {
    # Path may not exist yet; compute absolute from current location
    return [System.IO.Path]::GetFullPath($Path, (Get-Location).Path)
  }
}

function Paths-Equal {
  param(
    [Parameter(Mandatory)][string]$A,
    [Parameter(Mandatory)][string]$B
  )
  $aFull = Resolve-AbsolutePath $A
  $bFull = Resolve-AbsolutePath $B
  return ($aFull.TrimEnd('\','/')).ToLowerInvariant() -eq ($bFull.TrimEnd('\','/')).ToLowerInvariant()
}

# ----------------------- Safety checks -------------------------

function Ensure-SafeTarget {
  param([Parameter(Mandatory)][string]$TargetPath)

  if ([string]::IsNullOrWhiteSpace($TargetPath)) {
    Throw-Error "Target path is empty."
  }

  $targetAbs = Resolve-AbsolutePath $TargetPath

  # Refuse to operate on drive roots (e.g., C:\)
  $root = ([System.IO.Path]::GetPathRoot($targetAbs)).TrimEnd('\')
  if (($targetAbs.TrimEnd('\')) -eq $root) {
    Throw-Error "Refusing to operate on drive root: $targetAbs"
  }

  # Refuse to operate directly on the user's profile directory
  $userProfile = [Environment]::GetFolderPath('UserProfile')
  if ([string]::IsNullOrWhiteSpace($userProfile)) { $userProfile = $HOME }
  $userProfile = (Resolve-AbsolutePath $userProfile)
  if ((Paths-Equal $targetAbs $userProfile)) {
    Throw-Error "Refusing to operate on the user profile directory: $targetAbs"
  }

  # Strongly discourage operating on LOCALAPPDATA root
  $localAppData = $env:LOCALAPPDATA
  if (-not [string]::IsNullOrWhiteSpace($localAppData)) {
    $localAppData = (Resolve-AbsolutePath $localAppData)
    if ((Paths-Equal $targetAbs $localAppData)) {
      Throw-Error "Refusing to operate on LOCALAPPDATA root: $targetAbs"
    }
  }

  # Warn if target is not under HOME or LOCALAPPDATA
  $underHome = $false
  $underLocal = $false
  if (-not [string]::IsNullOrWhiteSpace($userProfile)) {
    $underHome = ($targetAbs + '\').ToLowerInvariant().StartsWith(($userProfile.TrimEnd('\') + '\').ToLowerInvariant())
  }
  if (-not [string]::IsNullOrWhiteSpace($localAppData)) {
    $underLocal = ($targetAbs + '\').ToLowerInvariant().StartsWith(($localAppData.TrimEnd('\') + '\').ToLowerInvariant())
  }

  if (-not ($underHome -or $underLocal)) {
    Write-Warn "Target is not under HOME or LOCALAPPDATA:"
    Write-Warn "  HOME:          $userProfile"
    if ($localAppData) { Write-Warn "  LOCALAPPDATA:  $localAppData" }
    Write-Warn "  TARGET:        $targetAbs"
    Write-Warn "Proceed only if you absolutely know what you're doing."
  }

  # Ensure target has at least one path component beyond root (already ensured by not being root)
}

# ----------------------- File ops ------------------------------

function Get-Children {
  param([Parameter(Mandatory)][string]$Dir)
  Get-ChildItem -LiteralPath $Dir -Force -ErrorAction SilentlyContinue
}

function Delete-Children {
  param([Parameter(Mandatory)][string]$Dir, [switch]$WhatIf)

  if ($WhatIf) {
    Write-Info "[dry-run] Would delete contents of: $Dir"
    Get-Children -Dir $Dir | ForEach-Object {
      Write-Info ("[dry-run] Would remove: " + $_.FullName)
    }
    return
  }

  $items = Get-Children -Dir $Dir
  foreach ($item in $items) {
    # Remove-Item -Recurse -Force has some quirks with long paths; this is the standard approach.
    Remove-Item -LiteralPath $item.FullName -Recurse -Force -ErrorAction Stop
  }
}

function Copy-All {
  param(
    [Parameter(Mandatory)][string]$SourceDir,
    [Parameter(Mandatory)][string]$TargetDir,
    [switch]$WhatIf
  )

  if ($WhatIf) {
    Write-Info "[dry-run] Would copy contents:"
    Write-Info "  $SourceDir -> $TargetDir"
    Get-ChildItem -LiteralPath $SourceDir -Force -ErrorAction SilentlyContinue | ForEach-Object {
      Write-Info ("[dry-run] Would copy: " + $_.FullName)
    }
    return
  }

  # Enumerate children (including hidden) and copy them into target
  $children = Get-ChildItem -LiteralPath $SourceDir -Force -ErrorAction SilentlyContinue
  foreach ($child in $children) {
    Copy-Item -LiteralPath $child.FullName -Destination $TargetDir -Recurse -Force -ErrorAction Stop
  }
}

# ----------------------- Defaults ------------------------------

# Compute default Target if not provided
if (-not $PSBoundParameters.ContainsKey('Target') -or [string]::IsNullOrWhiteSpace($Target)) {
  $xdgConfig = $env:XDG_CONFIG_HOME
  if ([string]::IsNullOrWhiteSpace($xdgConfig)) {
    $base = $env:LOCALAPPDATA
    if ([string]::IsNullOrWhiteSpace($base)) {
      $base = Join-Path $HOME ".config"
    }
  } else {
    $base = $xdgConfig
  }
  $Target = Join-Path $base "nvim"
}

# Normalize paths
$Source = Resolve-AbsolutePath $Source
$Target = Resolve-AbsolutePath $Target

# Validate source exists and is a directory
if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
  Throw-Error "Source directory does not exist: $Source"
}

# Create target if necessary (or show intent in dry-run)
if ($DryRun) {
  if (Test-Path -LiteralPath $Target -PathType Container) {
    Write-Info "[dry-run] Target exists: $Target"
  } else {
    Write-Info "[dry-run] Would create target directory: $Target"
  }
} else {
  New-Item -ItemType Directory -Force -Path $Target | Out-Null
}

# Re-resolve in case it was just created
$Target = Resolve-AbsolutePath $Target

# Prevent self-targeting
if (Paths-Equal $Source $Target) {
  Throw-Error "Source and target are the same path. Refusing to proceed:`n  $Source"
}

# Safety checks
Ensure-SafeTarget -TargetPath $Target

# ----------------------- Confirmation --------------------------

Write-Info "This will install Neovim config with the following settings:"
Write-Info "  Source: $Source"
Write-Info "  Target: $Target"
Write-Info "Actions:"
Write-Info "  - Delete ALL existing contents inside target"
Write-Info "  - Copy ALL files (including hidden) from source to target"

if (-not $Yes) {
  $reply = Read-Host "Proceed? Type 'yes' to continue [yes/N]"
  if (($reply ?? '') -notmatch '^(?i:yes)$') {
    Write-Info "Aborted."
    exit 0
  }
}

# ----------------------- Execution -----------------------------

Delete-Children -Dir $Target -WhatIf:$DryRun
Copy-All -SourceDir $Source -TargetDir $Target -WhatIf:$DryRun

Write-Info ("Done. Neovim config " + ($(if ($DryRun) { "(dry-run) would be " } else { "" })) + "installed to: $Target")
if ($DryRun) {
  Write-Info "Note: This was a dry run. No changes were made."
}
