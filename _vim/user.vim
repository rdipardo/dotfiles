"" ========================================================================
""    user.vim    Various useful Vim extensions
""    License:    https://github.com/rdipardo/dotfiles/blob/main/LICENSE
"" ========================================================================

" Return a file path with spaces and '\'s escaped
" a:000[0] file path to escape
function user#esc(...)
  let path = (empty(get(a:, 1, '')) ? expand('%:p') : get(a:, 1, ''))
  return escape(path, ' ,\')
endfunction

" Return a quoted file path
" a:000[0] file path to quote
function user#quote(...)
  return '"' . user#esc(get(a:, 1, '')) . '"'
endfunction

" Open a terminal buffer with the given command line.
" a:000[0] command line
" a:000[1] optional window title
function! user#launchTerm(...) abort
  let cmd = get(a:, 1, '')
  if empty(cmd) | return | endif

  let options = {
    \ 'cwd': expand('%:p:h'),
    \ 'term_name': (empty(get(a:, 2, '')) ? split(cmd)[0] : get(a:, 2, '')),
    \ 'hidden': 1,
    \ 'norestore': 1,
    \ 'term_finish': 'close'
    \ }

  let err_msg = '[' . options.term_name . '] Failed to open.'

  if has('terminal')
    let bufnr = term_start(cmd, options)
    if bufnr > 0
      if exists('*term_setkill') | call term_setkill(bufnr, 'term') | endif
      exec 'sbuf ' . bufnr
      resize 10
    else
      echom err_msg
    endif
  elseif has('nvim')
    let options.detach = 1
    unlet options.norestore
    let bufnr = nvim_create_buf(v:true, v:false)
    exec 'sbuf ' . bufnr
    resize 10
    let job = termopen(cmd, options)
    if !(job > 0)
      echom err_msg
    endif
  else
    exec '!\' . cmd
  endif
endfunction
