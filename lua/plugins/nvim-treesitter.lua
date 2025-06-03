return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  init = function()
    require'nvim-treesitter'.install{
      'c',
      'cpp',
      'rust',
      'c_sharp',
      'razor',
      'html',
      'css',
      'javascript',
      'jsdoc',
      'typescript',
      'go',
      'lua',
      'luadoc',
      'angular',
      'vue',
      'svelte',
      'tsx',
      'ocaml',
    }
  end
}
