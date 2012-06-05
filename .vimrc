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




" These functions demonstrate using python within vim by creating and removing breakpoints F7 and F8
python << EOF
import vim
def SetBreakpoint():
    import re
    nLine = int( vim.eval( 'line(".")'))

    strLine = vim.current.line
    strWhite = re.search( '^(\s*)', strLine).group(1)

    vim.current.buffer.append(
       "%(space)sfrom ipdb import set_trace;set_trace() %(mark)s Breakpoint %(mark)s" %
         {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

vim.command( 'map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
    import re

    nCurrentLine = int( vim.eval( 'line(".")'))

    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if strLine.lstrip()[:38] == 'from ipdb import set_trace;set_trace()':
            nLines.append( nLine)
            print nLine
        nLine += 1

    nLines.reverse()

    for nLine in nLines:
        vim.command( 'normal %dG' % nLine)
        vim.command( 'normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1

    vim.command( 'normal %dG' % nCurrentLine)

vim.command( 'map <f8> :py RemoveBreakpoints()<cr>')
EOF



"adds new modules with the 'gf' ability: hover over an import statemnet and use gf
"python << EOF
"import os,sys,vim
"for p in sys.path:
"    if os.path.isdir(p):
"        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
"EOF

