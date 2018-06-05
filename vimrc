" use pathogen (requires pathogen installed)
execute pathogen#infect()
syntax on
filetype plugin indent on

" use nerdtree (requires install, with pathogen)
map <C-n> :NERDTreeToggle<CR>

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
