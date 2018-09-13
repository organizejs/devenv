# devenv
This repo contains scripts and instructions on how to setup my development environment. Currently it is geared for python development, using VIM, on Ubuntu (16.04LTS).

## Pre-requisite:
- Ubuntu 16.04 LTS

## Install/setup components:
- MiniConda
  - Python3.6
- VIM
  - NERDTree
  - Jedi-vim
  - Pathogen (install tool)
- Tmux
- Bashrc

## Steps:
1. Copy the bashrc file to ~/.bashrc
2. Copy the vimrc file to ~/.vimrc
3. Copy the tmux.conf file to ~/.tmux.conf
4. [Install Pathogen for Vim Package installation](https://github.com/tpope/vim-pathogen)
5. [Install NERDTree with Pathogen](https://github.com/scrooloose/nerdtree#installation)
6. [Install Jedi-vim with Pathogen](https://github.com/davidhalter/jedi-vim#installation)

## For Data Science
1. [Install Conda](https://conda.io/docs/user-guide/install/linux.html) and use conda envs
2. [Setup Jupyter as a server)(https://jupyter-notebook.readthedocs.io/en/latest/public_server.html)
3. [Docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
