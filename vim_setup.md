# VIM + TMUX on Ubuntu
These instructions are for a new Ubuntu >= 16.04 LTS and assumes that the user works in conda environments. 

This setup will enhance VIM as an IDE in several ways:
1. File browsing and navigation
1. Autocompletion and inspecting class and function declaration/definition 
1. Folding classes and functions

## Reset VIM to factory settings
1. Uninstall vim and its dependencies: `sudo apt-get remove --auto-remove vim`
1. Purge config data: `sudo apt-get purge --auto-remove vim`
1. Remove configuration files: `rm -Rf ~/.vim ~/.vimrc ~/.viminfo`
1. Reinstall: `sudo apt-get install vim`

## Setup VIM
Follow these steps to setup VIM.

### vim-plug
All vim plugin installation will be handled by vim-plug (plugin manager for vim) https://github.com/junegunn/vim-plug. We will automatically install this in our `~/.vimrc` file.

## Vimrc
Create a vimrc in your root dir (`~/.vimrc`) and paste the following:

```bash
" install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'Valloric/YouCompleteMe'
    Plug 'tmhedberg/SimpylFold'
    Plug 'vim-airline/vim-airline'
call plug#end()

" allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" pretty
let python_highlight_all=1
syntax on

" numbering (hybrid relative + absolute number)
set number relativenumber

" PEP 8 indentation for python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" web dev indentation
au BufNewFile,BufRead *.js, *.html, *.css 
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" flag bad whitespace
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF-8 support
set encoding=utf-8

" SimpylFold Config
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

" YouCompleteMe Config
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoTo<CR>

" " NERDTree Config
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']

" netrw Config
" let g:NetrwIsOpen=0
" function! ToggleNetrw()
"     if g:NetrwIsOpen
"         let i = bufnr("$")
"         while (i >= 1)
"             if (getbufvar(i, "&filetype") == "netrw")
"                 silent exe "bwipeout " . i
"             endif
"             let i-=1
"         endwhile
"         let g:NetrwIsOpen=0
"     else
"         let g:NetrwIsOpen=1
"         silent Lexplore
"     endif
" endfunction

" noremap <silent> <C-n> :call ToggleNetrw()<CR>
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 2
" let g:netrw_altv = 1
" let g:netrw_winsize = 15
```

Open vim and run `:PlugInstall` to install the specified plugins. After this, NerdTree and SimpylFold will work. However, YouCompleteMe will need additional installation and configuration.

## YouCompleteMe
Install development tools, CMake, and Python headers:
```bash
sudo apt install build-essential cmake python3-dev
```

Navigate to `~/.vim/plugged/YouCompleteMe` and run `python install.py`. This will enable YouCompleteMe to work on your default python path.

To make YouCompleteMe work within a conda environment, create a `.ycm_extra_conf.py` file in the root of your project directory, and paste the following into it:
```python
def Settings( **kwargs ):
  return {
    'interpreter_path': '/path/to/virtual/environment/python'
  }
```
To find out the path to your virtual environment python, make sure you are in your conda environment and run `which python`. 

With this setup, the recommendation is to use a single conda environment per project (each project should be contained to a single directory) so that the `.ycm_extra_conf.py` file is stored in each project dir. 

Do not forget to add the `.ycm_extra_conf.py` file to your `.gitignore`.

---
## Tmux

- Add `[ -n "$TMUX" ] && export TERM=screen-256color` to .bashrc file
---


Inspiration: https://realpython.com/vim-and-python-a-match-made-in-heaven/#vim-in-the-shell
