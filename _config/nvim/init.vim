""      Plugin Configuration  {{{
""
lua require ('config.lazy')

if (!empty(globpath(&rtp, 'user.vim', 0, 0))) | runtime user.vim | endif

augroup CorePlugins
  au VimEnter *
  \ :exe 'lua require ("config.lspconfig")' |
  \ :exe 'lua require ("config.telescope")' |
  \ :exe 'lua require ("config.mini-surround")'
augroup END

""" vlime {{{
"" first install and configure quicklisp: https://www.quicklisp.org/beta/#loading
augroup LoadVlime
    autocmd!
    au FileType lisp ++once :lua require ('config.vlime')
augroup END
" }}}

augroup SetupLLDB
  autocmd!
  au FileType c,cpp ++once
  \ :exec 'lua vim.lsp.enable({ "clangd" })' |
  \ :exec 'lua require("config.dap.cpp")'
augroup END

augroup LoadRustAnalyzer
  autocmd!
  au FileType rust ++once :lua vim.lsp.enable({ 'rust-analyzer' })
augroup END

augroup LoadFSAC
  autocmd!
  au FileType fsharp ++once
  \ :exe 'lua require ("config.setup-fsac")' |
  \ :nnoremap <silent> <leader>l <ESC> :call user#launchTerm('dotnet fsi --load:' . user#quote(), 'F# Interactive')<CR>
augroup END

"" FORTH
augroup ForthConfig
    au VimEnter,BufReadPost *.*4,*.4th,*.forth,*.frt,*.fth :setl ft=forth
    au FileType forth ++once
    \ :nnoremap <leader>l <ESC> :call user#launchTerm('gforth '. user#quote())<CR>
augroup END

"" Maxima
augroup MaximaConfig
    au BufNewFile,BufRead *.mac,*.mc,*.wxm :set ft=maxima
    au FileType maxima ++once
    \ nnoremap <leader>e :exec '!maxima --very-quiet < '. user#quote()<CR>
augroup END

"" (Chez) Scheme
augroup SchemeConfig
    au FileType scheme ++once
    \ :nnoremap <C-L> <ESC> :call user#launchTerm('scheme '. user#quote())<CR>
augroup END

"" zig.vim
"" https://github.com/ziglang/zig.vim/issues/51
let g:zig_fmt_autosave = 0
" }}}

""      General Vim Settings {{{
set shellcmdflag=-ic
set fileencodings=utf-8,latin1
set encoding=utf-8
scriptencoding utf-8

""" Window Behaviour
set wildmenu "show completions in status bar
set completeopt+=noselect
set laststatus=2

"" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

"" NETRW browser tweaks: https://www.youtube.com/watch?v=XA2WjJbmmoM
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_keepdir = 0

"" https://shapeshed.com/vim-netrw/#changing-the-directory-view-in-netrw
let g:netrw_altv = 1
let g:netrw_winsize = 20

augroup EditorDefaults
  autocmd!
  let g:xml_syntax_folding = 1
  au FileType xml,html,xhtml :setlocal foldmethod=syntax
  au BufRead,BufNewFile *.markdown,*.md,*.rst,*.textile,*.txt :setlocal spell
  au FileType gitcommit :setlocal spell
  "" trim trailing space on save
  au BufWritePre * :%s/\s\+$//e
augroup END

""" Colours {{{
set background=dark
colorscheme industry
set termguicolors "Switch off for WSL!

if index(getcompletion('', 'color'), 'catppuccin') > -1
  colorscheme catppuccin-mocha
elseif index(getcompletion('', 'color'), 'tokyonight') > -1
  let s:theme = has('win32') ? 'moon' : 'night'
  exe 'colorscheme tokyonight-' . s:theme
elseif index(getcompletion('', 'color'), 'deep-space') > -1
  colorscheme deep-space
  let g:deepspace_italics=1
  let g:lightline = {'colorscheme': 'deepspace'}
elseif index(getcompletion('', 'color'), 'darkspace') > -1
  colorscheme darkspace
  let g:darkspace_italics=1
  let g:airline_theme='darkspace'
  let g:airline_extensions = []
else
  " colorscheme hydrangea
  " let g:lightline = { 'colorscheme': 'hydrangea' }
endif

"" https://stackoverflow.com/a/3316521
if has('gui_running')
  if has('gui_gtk2')
    set guifont=Inconsolata\ 12
  elseif has('gui_macvim')
    set guifont=Menlo\ Regular:h14
  elseif has('gui_win32')
    set guifont=Consolas:h11:cANSI
  endif
endif

set guicursor=n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:hor20
" }}}

""" Editor {{{
syntax on
filetype plugin indent on
set nu
set hls
set spelllang=en_ca
set lcs+=space:·
"" https://github.com/vim/vim/blob/master/runtime/syntax/pascal.vim#L181
let g:pascal_fpc=1

""
"" From https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
""
set shiftwidth=4 " 1 tab == 4 spcs
set tabstop=4
set expandtab " Render tabs as spaces
set smarttab
set ai " Auto indent
set si " Smart indent

set lbr
set tw=500 " break after 500 characters
set wrap " wrap lines

set noswapfile " keep source trees clean
" }}}

""" Key mappings {{{

"" hide search matches: https://stackoverflow.com/a/657457
nnoremap <silent> <Space>h :noh<CR>
nnoremap <silent> <Space>s :w %<CR>

" clipboard copy/paste
vnoremap <silent> <C-C> <Esc>"*yv
nnoremap <silent> <C-V> <Esc>"*p<Esc>
inoremap <buffer> <C-V> <Esc>"*pa

"" Quick exit
tnoremap <silent> <Esc><Esc> <C-\><C-n> :wincmd k<CR>
nnoremap <silent> <F10> :set awa<CR>:qa<CR>
" }}}

" }}}
" vim: foldmethod=marker
