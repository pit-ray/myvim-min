" => Encoding settings -----------------------------------------------{{{1
set encoding=utf-8
set fileformats=unix,dos,mac
set nocompatible
set fileencodings=utf-8,cp932,euc-jp,iso-20220-jp,default,latin
scriptencoding

" => Common bindings --------------------------------------------------{{{1
let mapleader = "\<space>"

" => Install plugins --------------------------------------------------{{{1
let $VIMHOME = $HOME . (has('win32') ? '/vimfiles' : '/.vim')
if empty(glob($VIMHOME . '/autoload/plug.vim'))
    exe('term curl -fLo ' . $VIMHOME . '/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim')
    au! VimEnter * PlugInstall --sync | so $MYVIMRC
endif

call plug#begin($VIMHOME . '/plugged')
" Try
Plug 'vim-scripts/DoxygenToolkit.vim'

" Stable
Plug 'agatan/vim-sort-include'
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'cpiger/NeoDebug'
Plug 'sainnhe/gruvbox-material'
Plug 'wordijp/NeoDebug'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'mattn/vim-lsp-settings'
Plug 'mhinz/vim-startify'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'simeji/winresizer'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vhdirk/vim-cmake', {'for': ['c', 'cpp']}
Plug 'vim-airline/vim-airline'
Plug 'vim-scripts/nsis.vim', {'for': ['nsi', 'in']}
call plug#end()

"enable dgb debugger
packadd termdebug

command! Update so<space>$MYVIMRC | PlugInstall
command! So so<space>$MYVIMRC

au! BufNewFile,BufRead *.vindrc set filetype=vim

" => Plugin Options -------------------------------------------------{{{1
" vim-sort-include
au! BufWritePre *.{c,cpp,h,hpp,cc} SortInclude

"vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_log_verbose=1
let g:lsp_log_file = expand($VIMHOME . '/vim-lsp.log')

let g:asyncomplete_log_file = expand($VIMHOME . '/asyncomplete.log')

"vim-lsp-settings
let g:lsp_settings_root_markers = ['.git']
let g:lsp_settings_servers_dir  = $VIMHOME . '/vim-lsp-settings/servers'
let g:lsp_settings_filetype_py = ['pyls-all']
command! Def sp | LspDefinition
command! Dec sp | LspDeclaration
noremap <leader>d :LspDefinition<cr>

"vim-vinegar
let g:NERDTreeHijackNetrw = 0

"ctrlp
let g:ctrlp_working_path_mode = 'ra'

"vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
command! -range Eqga <line1>,<line2>EasyAlign<Space>-=

"vim-easymotion
nmap f <Plug>(easymotion-f)
nmap F <Plug>(easymotion-overwin-f)

nmap t <Plug>(easymotion-w)
nmap T <Plug>(easymotion-b)

nmap s <Plug>(easymotion-s2)

"NeoDebug
let g:neodbg_debugger              = 'gdb'
let g:neodbg_gdb_path              = 'gdb'
let g:neodbg_cmd_prefix            = 'GDB'
let g:neodbg_console_height        = 5
let g:neodbg_openbreaks_default    = 1
let g:neodbg_openstacks_default    = 1
let g:neodbg_openthreads_default   = 0
let g:neodbg_openlocals_default    = 0
let g:neodbg_openregisters_default = 0

" => Color Scheme --------------------------------------------------{{{1
syntax enable
set background=dark
if has('termguicolors')
    set termguicolors
endif

let g:gruvbox_material_background = 'soft'
let g:airline_theem = 'gruvbox_material'

if has('syntax')
    au! Colorscheme * highlight FullWidthSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    au! VimEnter,WinEnter * match FullWidthSpace /　/
endif
colorscheme gruvbox-material

" => Native Common Settings ----------------------------------------------{{{1
set hlsearch                        "show highlight
set showmatch                       "show matched brackets
set ruler                           "show cursor position
set number                          "show line number
set showcmd                         "show inputting commands
set list                            "show invisible char
set listchars=tab:>-,trail:.        "tab - space .
if has('gui_running') && has('vim_starting')
    set lines=32                        "initial window height
    set columns=128                     "initial window width
endif

"indent
filetype plugin indent on           "detect filetype
set autoindent                      "automatic indent
set expandtab                       "convert tab to space
set tabstop=4                       "tab = 4 spaces
set shiftwidth=4                    "the number of space in auto indent
set foldmethod=marker               "fold with maker (e.g. {{{1)
set foldlevel=100                   "initial fold mode

"other
set nowrapscan                      "There is End of search
set nowrap                          "not wrap a long line

set nobackup                        "not make backup files
set noswapfile                      "not make swap files
set backspace=indent,eol,start      "behavior of back space
set clipboard=unnamed,autoselect    "copy to OS's clipboard
set wildmenu                        "more informational completion
set wildmode=list:longest,full      "wildmenu's behavior

set novb t_vb=                      "disable all beep
set noerrorbells                    "disable error beep

if has('win32')
    set shell=powershell
endif

set undodir=$VIMHOME                "infinity undo

" => Native GUI settings -------------------------------------------------{{{1
set guioptions-=m                   "disable gui menubar
set guioptions-=T                   "disable gui toolbar
set guifont=Consolas:h8

" => My bindings ---------------------------------------------------------{{{1
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

noremap <m-l> :cn<cr>
noremap <m-h> :cp<cr>

if has('terminal')
    tnoremap <c-h> <c-w><c-h>
    tnoremap <c-j> <c-w><c-j>
    tnoremap <c-k> <c-w><c-k>
    tnoremap <c-l> <c-w><c-l>
endif

let g:termdebug_use_prompt = 0
noremap <leader>b :Break<cr>
noremap <f5> :Continue<cr>
noremap <leader>e :Evaluate<cr>
noremap <leader>g :Gdb<cr>
noremap <leader>s :Step<cr>
noremap <leader>o :Over<cr>
noremap <leader>q :Gdb<cr><esc>iquit<cr>
noremap <leader>r :Run<cr><esc>:Source<cr>

" => My functions  ---------------------------------------------------------{{{1
let g:previous_word_under_cursor = ''
function! EvaluateUnderCursor() abort
    if exists(':Evaluate')
        let l:word = expand('<cword>')
        if !empty(l:word) && l:word != ' '
            if g:previous_word_under_cursor != l:word
                Evaluate
                let g:previous_word_under_cursor = l:word
            endif
        endif
    endif
endfunction

set updatetime=700
au! CursorHold * call EvaluateUnderCursor()


"Utilities
function! StartNewLineWithRemoveSP() abort
    let l:startcol = col('.')
    normal w
    let l:spnum = col('.') - l:startcol - 1
    if l:spnum > 0
        for a in range(l:spnum)
            normal X
        endfor
    endif
    execute "normal i\<cr>\<esc>"
endfunction

"In C/C++
"[from] void myfunction(int a, int b) ;
"[to]   void myfunction(
"           int a,
"           int b) ;
function! AlignArgs() abort
    let l:startq = '('
    let l:endq   = ')'
    let l:delim  = ','

    call cursor(0, 1)
    call search(l:startq)
    if searchpair(l:startq, '', l:endq, 'n') < 1
        echo "not found pair"
    endif
    call StartNewLineWithRemoveSP()

    while 1
        let [l:plnum, l:pcol] = searchpairpos(l:startq, '', l:endq, 'n')
        let [l:dlnum, l:dcol] = searchpos(l:delim, 'n')
        if l:dlnum == 0 || l:dcol == 0 || l:dlnum > l:plnum || l:dcol > l:pcol
            break
        endif
        call cursor(l:dlnum, l:dcol)
        call StartNewLineWithRemoveSP()
    endwhile
endfunction
noremap <leader>a :call AlignArgs()<cr>

"In C/C++
"Template Generator
"-Support
":Template CPP
":Template C
":Template H
function! InsertText(insert_text) abort
    execute ":normal i" . a:insert_text
endfunction

function! InsertTemplate(type) abort
    let l:lower_type = tolower(a:type)

    if l:lower_type == "cpp"
        call InsertText("#include <iostream>\n\nint main()\n{\n\n}")
    elseif l:lower_type == "c"
        call InsertText("#include <stdio.h>\n\nint main()\n{\n\n}")
    elseif l:lower_type == "h" || l:lower_type == "hpp"
        let l:filename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
        call InsertText("#ifndef _" . l:filename . "\n#define _" . l:filename . "\n\n#endif")
    else
        echo "not supported"
    endif
endfunction

command! -nargs=1 Template :call InsertTemplate(<f-args>)<cr>

"win-vind (https://pit-ray.github.io/win-vind/)
command! GUINormal :AsyncRun win-vind -f change_to_normal

function! Dos2Unix() abort
    edit! ++ff=unix
    execute "%s///ge"
    execute "%s/\r//ge"
endfunction

command! Dos2Unix :call Dos2Unix()
