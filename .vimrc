:set autoindent
:set cindent
execute pathogen#infect()
:syntax on
:filetype plugin indent on
filetype plugin on
let Tlist_Use_Right_Window   = 1
let Tlist_Auto_Open = 1
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
let Tlist_GainFocus_On_ToggleOpen = 1
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
