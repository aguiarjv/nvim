-- Trim white spaces and use neoformat plugin

vim.cmd([[

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup fmt
  autocmd!
  autocmd BufWritePre * : call TrimWhitespace()
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]])
