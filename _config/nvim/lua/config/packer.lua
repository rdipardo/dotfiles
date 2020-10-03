-- https://github.com/wbthomason/packer.nvim#bootstrapping
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  --
  -- Colorschemes
  --
  use 'sro5h/vim-darkspace'
  use 'folke/tokyonight.nvim'
  use 'yuttie/hydrangea-vim'
  use 'bcat/abbott.vim'
  use 'NLKNguyen/papercolor-theme'
  use 'vim-airline/vim-airline'

  --
  -- Language support
  --
  use {
    'nvim-treesitter/nvim-treesitter',
    ft = {
      'c', 'cpp', 'css', 'gitcommit', 'json', 'lua', 'make', 'pascal',
      'python', 'rust', 'sh', 'sql', 'vim', 'html'
    },
    config = 'vim.cmd[[TSUpdate]]'
  }
  -- use {
    -- 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }
  -- }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/vim-vsnip'
  use { 'hrsh7th/cmp-vsnip', branch = 'main' }
  use { 'hrsh7th/cmp-nvim-lsp', branch = 'main' }
  use { 'hrsh7th/cmp-buffer', branch = 'main' }
  use { 'hrsh7th/cmp-path', branch = 'main' }
  use { 'echasnovski/mini.surround', branch = 'stable' }
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'neovim/nvim-lspconfig'

  -- best to install universal-ctags from source:
  -- https://github.com/universal-ctags/ctags#how-to-build-and-install
  -- https://github.com/preservim/tagbar
  use 'preservim/tagbar'

  -- reStructuredText editing, live previews
  use 'Rykka/riv.vim'
  use 'Rykka/InstantRst'

  -- Markdown
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

  -- easily toggle line comments, swap lines
  use 'tpope/vim-commentary'
  use 'krcs/vim-movelines'

  -- LISP and family
  use { 'vlime/vlime', rtp = 'vim/' }
  use 'guns/vim-sexp'
  use 'tpope/vim-sexp-mappings-for-regular-people'
  use 'luochen1990/rainbow'

  -- Prolog syntax
  use 'yochem/prolog.vim'

  -- ARM assembly syntax
  use 'ARM9/arm-syntax-vim'

  -- MIPS assembly syntax
  use 'benknoble/vim-mips'

-- Kotlin
-- use 'udalov/kotlin-vim'

-- Rust
-- use 'rust-lang/rust.vim'

-- F# syntax and FSI integration
  use { 'ionide/Ionide-vim' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
