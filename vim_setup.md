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

In order for YouCompleteMe to work, you will need the latest version of vim. The steps above won't get you the latest version of vim. To get the latest, (8.2 as of the time of writing), run the following:
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```


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
```

Open vim and run `:PlugInstall` to install the specified plugins. After this, NerdTree and SimpylFold will work. However, YouCompleteMe will need additional installation and configuration.

## YouCompleteMe
Install development tools, CMake, and Python headers:
```bash
sudo apt install build-essential cmake python3-dev
```

Navigate to `~/.vim/plugged/YouCompleteMe` and run `python install.py`. This will enable YouCompleteMe to work on your default python path.

> When installing YouCompleteMe, you may run into the following error: ```**Your C++ compiler does NOT fully support C++17.** ```. Visit this post to overcome the issue: https://stackoverflow.com/questions/65284572/your-c-compiler-does-not-fully-support-c17

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
