# VIM on Ubuntu
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
Install vim-plug (plugin manager for vim) https://github.com/junegunn/vim-plug
```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Vimrc
Create a vimrc in your root dir (`~/.vimrc`) and paste the following:

```bash
" vim-plug
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'Valloric/YouCompleteMe'
    Plug 'tmhedberg/SimpylFold'
call plug#end()

" pretty
let python_highlight_all=1
syntax on

" numbering (hybrid relative + absolute number)
set number relativenumber

" PEP 8 indentation
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

" NERDTree Config
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " close if only NERTree view remains
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']
```

Open vim and run `:PlugInstall` to install the specified plugins. After this, NerdTree and SimpylFold will work. However, YouCompleteMe will need additional installation and configuration.

## YouCompleteMe
Navigate to `~/.vim/plugged/YouCompleteMe` and run `python install.py`. This will enable YouCompleteMe to work on your default python path.

To make YouCompleteMe work within a conda environment, create a `.ycm_extra_conf.py` file in the root of your project directory, and paste the following into it:
```python
def Settings( **kwargs ):
  return {
    'interpreter_path': '/path/to/virtual/environment/python'
  }
```
To find out the path to your virtual environment python, make sure you are in your conda environment and run `which python`. 
