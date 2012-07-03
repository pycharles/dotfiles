" I've emerged vimpython for new commands
set expandtab
set tabstop=2
map <f2> :w\|!python %<cr>
" Toggle line numbers with F2
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>
" allows using > and < to change indentation for a block (use v for visual mode)
set shiftwidth=2 
"autoindent the start of these blocks
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class 
"use ctags to generate an index of all the code for vim to reference, generate with: ctags -R -f ~/.vim/tags/python.ctags /usr/lib/python2.5/
set tags+=$HOME/.vim/tags/python.ctags
"code completion remapped to Ctrl-space is next 2 lines
autocmd FileType python set omnifunc=pythoncomplete#Complete
inoremap <Nul> <C-x><C-o>
let g:pydoc_cmd = "/usr/bin/pydoc"
"so $HOME/.vim/plugins/pydoc.vim


" minibufexpl.vom settings (buffer upper window)
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

"make home key go to first non-whitespace
map <Home> ^
imap <Home> <Esc>^i


"Easier mapleader than the default "\"
let mapleader = ","
" type ,p to insert breakpoint.  is at the end.  Insert with ctrl v and then esc 
" (the github web gui doesn't display control characters, but it is there)
nnoremap <leader>p oimport ipdb;ipdb.set_trace()
" make W key 'wipe' the whole line clean but keep the \n
nnoremap <leader>W 0d$
