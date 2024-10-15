function! ClipboardYank()
  call system('echo '.shellescape(join(v:event.regcontents, "\n")).' | nc clipboard 12345')
endfunction

autocmd TextYankPost * if v:event.operator ==# 'y' | call ClipboardYank() | endif
