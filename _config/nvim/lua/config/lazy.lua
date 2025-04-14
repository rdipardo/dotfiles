-- https://github.com/folke/lazy.nvim#-installation
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/lazy/lazy.nvim"
local ensure_lazy = function()
  local installed = (fn.empty(fn.glob(install_path)) == 0)
  if (not installed) then
    fn.system({'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim.git', install_path})
  end
  return (vim.uv or vim.loop).fs_stat(install_path)
end
if (ensure_lazy()) then vim.opt.rtp:prepend(install_path) end

require('lazy').setup({
  --
  -- Colorschemes
  --
  {
    'vim-airline/vim-airline',
    config = function()
      vim.cmd([[ AirlineTheme catppuccin ]])
    end
  },
  { 'folke/tokyonight.nvim', tag = 'v3.0.1'},
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'RomanAverin/charleston.nvim', lazy = true },
  -- { 'shaunsingh/moonlight.nvim', lazy = true },
  -- { 'leet0rz/modified-moonlight.nvim' },
  { 'sro5h/vim-darkspace', lazy = true },
  { 'yuttie/hydrangea-vim', lazy = true },
  { 'bcat/abbott.vim', lazy = true },
  { 'NLKNguyen/papercolor-theme', lazy = true },

  --
  -- Language support
  --
  {
    'nvim-treesitter/nvim-treesitter',
    ft = {
      'c', 'cpp', 'cs', 'css', 'gitcommit', 'json', 'lua', 'markdown', 'markdown_inline', 'make', 'pascal',
      'python', 'rust', 'sh', 'sql', 'vim', 'html'
    },
    config = function()
      vim.cmd([[ TSUpdate ]])
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'nvim-neotest/nvim-nio' },
      { 'rcarriga/nvim-dap-ui' }
    },
    lazy = true
  },
  {
    'saghen/blink.cmp',
    dependencies = 'rafamadriz/friendly-snippets',
    version = 'v1.*',
    opts = {
      -- https://github.com/Saghen/blink.cmp/issues/1412#issuecomment-2708816287
      fuzzy = { implementation = 'lua' },
      keymap = { preset = 'super-tab' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' },
      },
      completion = {
        trigger = {
          show_on_insert_on_trigger_character = false,
        },
      },
      signature = { enabled = true } -- experimental
    },
    opts_extend = { "sources.default" }
  },
  { 'echasnovski/mini.surround', branch = 'stable'},

  -- SCM integration
  {
    'sindrets/diffview.nvim',
    dependencies = { {'nvim-tree/nvim-web-devicons'} },
    config = function()
      vim.keymap.set('n', '<Leader>=', function() vim.cmd(':DiffviewOpen') end)
      vim.keymap.set('n', '<Leader>-', function() vim.cmd(':DiffviewClose') end)
    end
  },

  -- best to install universal-ctags from source:
  -- https://github.com/universal-ctags/ctags#how-to-build-and-install
  -- https://github.com/preservim/tagbar
  {
    'preservim/tagbar',
    init = function() vim.cmd('nmap <silent> <F12> :TagbarToggle<CR>') end
  },

  -- reStructuredText editing, live previews
  {
    'previm/previm',
    dependencies = 'tyru/open-browser.vim',
    ft = { 'rst', 'markdown', 'textile' },
    config = function()
      local open_cmd = 'xdg-open'
      if (os.getenv('WINDIR')) then
        open_cmd = ''
      end
      vim.cmd(string.format("let g:previm_open_cmd=%q", open_cmd))
      vim.cmd('let g:previm_enable_realtime=1')
    end
  },
  {
      "OXY2DEV/markview.nvim",
      ft = "markdown",
      dependencies = {
          "nvim-treesitter/nvim-treesitter",
          "nvim-tree/nvim-web-devicons"
      }
  },

  -- easily toggle line comments, swap lines
  'tpope/vim-commentary',
  {
    'rdipardo/vim-cpywrite',
    config = function()
      vim.cmd([[ let g:cpywrite#hide_filename=1 ]])
    end
  },

  -- LISP and family
  {
    'luochen1990/rainbow',
    ft = { 'lisp', 'clojure', 'racket', 'scheme' },
    init = function() vim.cmd('let g:rainbow_active = 1') end
  },
  { 'vlime/vlime', rtp = 'vim/', ft = 'lisp' },
  { 'guns/vim-sexp', ft = { 'lisp', 'clojure', 'racket', 'scheme' } },
  { 'tpope/vim-sexp-mappings-for-regular-people', ft = { 'lisp', 'clojure', 'racket', 'scheme' } },

  -- Prolog syntax
  { 'yochem/prolog.vim', event = "BufReadPost *.pl,*.plt,*.pro"},

  -- ARM assembly syntax
  {
    'ARM9/arm-syntax-vim',
    init = function()
      vim.cmd([[ au VimEnter,BufReadPost *.[sS] setl filetype=arm ]])
    end
  },

  -- MIPS assembly syntax
  { 'benknoble/vim-mips', ft = 'mips' },

-- Kotlin
-- 'udalov/kotlin-vim'

-- Rust
-- 'rust-lang/rust.vim'
-- { 'mrcjkb/rustaceanvim', ft = 'rust' },

-- F# syntax
  'PhilT/vim-fsharp',

-- C#
  {
    'seblyng/roslyn.nvim',
    ft = 'cs',
    opts = {
        -- https://github.com/seblyng/roslyn.nvim#%EF%B8%8F-configuration
    }
  }
},
{
  defaults = {
    lazy = false,
  }
})
