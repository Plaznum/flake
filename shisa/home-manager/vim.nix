{ config, lib, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      ale
      vim-airline
      vim-airline-themes
      vim-lastplace
      vim-nix
    ];
    extraConfig = ''
      set shiftwidth=3 smarttab
      set expandtab
      set tabstop=8 softtabstop=0
      set number relativenumber
      set encoding=utf8
      set mouse=a
      set ruler
      let g:airline_theme = 'owo'
      " highlight & increment searches
      set incsearch
      set hlsearch
      " Autocomplete <ctrl + n> based on existing strings in document (i think)
      set wildmode=longest,list,full
      " Split screen open at bottom and right
      set splitbelow splitright
      " Split screen navigation shortcuts
      map <C-h> <C-w>h
      map <C-j> <C-w>j
      map <C-k> <C-w>k
      map <C-l> <C-w>l
      " replace all alias to S
      nnoremap S :%s//g<Left><Left>
    '';
  };
}
