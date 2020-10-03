local p = require("lazy.core.config").plugins
if p and p['vlime'] and p['vlime']._.loaded then
    vim.cmd([[
        let g:vlime_cl_impl = 'clisp'
        function! VlimeBuildServerCommandFor_clisp(vlime_loader, vlime_eval)
            return [g:vlime_cl_impl,
                    \ '-i', '~/quicklisp/setup.lisp',
                    \ '-i', a:vlime_loader,
                    \ '-x', a:vlime_eval,
                    \ '-repl',
                    \ '--quiet']
        endfunction
    ]])
end
