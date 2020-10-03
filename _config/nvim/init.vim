""      Plugin Configuration  {{{
""
lua require ('config.packer')

augroup CorePlugins
  au VimEnter *
  \ :exe 'lua require ("config.cmp")' |
  \ :exe 'lua require ("config.mason-lspconfig")' |
  \ :exe 'lua require ("config.mini-surround")'
augroup END

""" vlime {{{
"" first install and configure quicklisp: https://www.quicklisp.org/beta/#loading
augroup LoadVlime
    autocmd!
    au FileType lisp :lua require ('config.vlime')
augroup END
" }}}

""" Ionide-vim {{{
""
augroup LoadIonide
  autocmd!
  au BufNewFile,BufRead *.fs,*.fsx,*.fsi,*.fsscript
  \ :exe 'lua require ("config.ionide")' |
  \ :setlocal hidden |
  \ :let mapleader = '\' |
  \ :let g:fsharp#fsi_keymap = 'vim-fsharp' |
  \ :let g:fsharp#exclude_project_directories = ['paket-files'] |
  \ :let g:fsharp#lsp_auto_setup = 0 |
  \ :nnoremap <silent> <leader>l <ESC>:call fsharp#sendFsi('#load @"' . expand('%:p') . '"') <CR> |
  \ :nnoremap <silent> <leader>o <ESC>:call fsharp#sendFsi('open ' . expand('%:t:r')) <CR>
augroup END
" }}}

""" riv.vim {{{
""
let g:riv_section_levels = '=-^"''`'
let g:riv_fold_auto_update = 0
let g:instant_rst_localhost_only = 1

augroup RivUpdateFolds
    autocmd!
    au BufNewFile,BufRead *.rst :norm zx zi
    au BufWritePost *.rst :norm zx zi
augroup END
" }}}

""" rainbow
""
let g:rainbow_active = 1

""" Tagbar
""
nmap <silent> <F12> :TagbarToggle<CR>

"" vim-movelines
nnoremap <silent> <A-DOWN> :call MoveLineNormal("d")<CR>
vnoremap <silent> <A-DOWN> :call MoveLinesVisual("down")<CR>

"" Maxima
augroup MaximaConfig
    au BufNewFile,BufRead *.mac,*.mc,*.wxm :set ft=maxima
    au FileType maxima
    \ nnoremap <F8> :exec '!maxima --very-quiet < '.escape(expand('%'), ' ,\')<CR>
augroup END

" }}}

""      General Vim Settings {{{
set fileencodings=utf-8,latin1
set encoding=utf-8
scriptencoding utf-8

""" Window Behaviour
set wildmenu "show completions in status bar
set laststatus=2

"" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitbelow
set splitright

"" NETRW browser tweaks: https://www.youtube.com/watch?v=XA2WjJbmmoM
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3

"" https://shapeshed.com/vim-netrw/#changing-the-directory-view-in-netrw
let g:netrw_altv = 1
let g:netrw_winsize = 20

augroup EditorDefaults
  autocmd!
  au VimEnter * :Vexplore | :wincmd l
  au BufRead,BufNewFile *.markdown,*.md,*.rst,*.textile,*.txt :setlocal spell
  au FileType gitcommit :setlocal spell
  "" trim trailing space on save
  au BufWritePre * :%s/\s\+$//e
augroup END

""" Colours {{{
set background=dark
colorscheme industry
set termguicolors "Switch off for WSL!

if index(getcompletion('', 'color'), 'tokyonight') > -1
  colorscheme tokyonight-night
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

"" Surround with quote: https://stackoverflow.com/a/2148055
nnoremap qw ciw'<C-r>"'<Esc>
nnoremap qqw ciw"<C-r>""<Esc>
nnoremap sw ciw(<C-r>")<Esc>
nnoremap swb v%c[<C-r>"]<Esc>
nnoremap swcb v%c{<C-r>"}<Esc>

"" hide search matches: https://stackoverflow.com/a/657457
nnoremap <silent> <Space>h :noh<CR>
nnoremap <silent> <Space>s :w %<CR>

" clipboard copy/paste
vnoremap <silent> <C-C> <Esc>"*yv
nnoremap <silent> <C-V> <Esc>"*p<Esc>
inoremap <buffer> <C-V> <Esc>"*pa

"" Quick exit
nnoremap <silent> <F10> :set awa<CR>:qa<CR>
" }}}

" }}}
" vim: foldmethod=marker
