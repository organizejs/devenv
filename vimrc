" use pathogen (requires pathogen installed)
execute pathogen#infect()
syntax on
filetype plugin indent on

set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.

set shiftwidth=2    " Indents will have a width of 2

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

set background=dark " Tells vim that the background is
                    " so the text needs to be light


" install jedi-vim (with pathogen)

" override python filetype plugin to use 2 spaces on tab
augroup python
    autocmd!
    autocmd FileType python setlocal ts=2 sts=2 sw=2
augroup end

" prevent ctrl-z from exiting vim session
nnoremap <c-z> <nop>

" " NERDTree Config
" map <C-n> :NERDTreeToggle<CR>
" let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']

" netrw Config
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

noremap <silent> <C-n> :call ToggleNetrw()<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
