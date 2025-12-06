{ config, pkgs, ... }:
{

  # global
  # for user lvl
  # replace with: users.users.pandy = { packages = with pkgs; [
  environment.systemPackages = with pkgs; [
    ((vim_configurable.override {  }).customize{
     name = "vim";
# Install plugins for example for syntax highlighting of nix files
     vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
     start = [ vim-nix vim-lastplace ale vim-airline vim-airline-themes ];
     opt = [];
     };
     vimrcConfig.customRC = ''
     set mouse=a
     colorscheme default
     "set mouse-=a
     "set number
     set backspace=indent,eol,start
     set number relativenumber
     set paste
     set ruler
     set encoding=utf8
     " make tabs not feel like trash
     set tabstop=3
     set shiftwidth=3
     set expandtab
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
     " Newtab
     nnoremap <silent> <C-t> :tabnew<CR>
     syntax on
     set nocompatible              " be iMproved, required
     "filetype off                  " required
     filetype plugin on                  " required
     hi Normal guibg=NONE ctermbg=NONE
     hi NonText guibg=NONE ctermbg=NONE
     " ALE keybindings
     nmap <silent> <C-k> <Plug>(ale_previous_wrap)
     nmap <silent> <C-j> <Plug>(ale_next_wrap)
     let g:ale_completion_enabled = 1
     let g:ale_linters = {'go': ['gofmt', 'golint', 'go vet', 'gometalinter'],'perl':['perl','perlcritic']}
     " Airline Options
       "let g:airline_theme = 'simple'
       let g:airline_theme = 'owo'
       hi airline_c  ctermbg=NONE guibg=NONE
       hi airline_tabfill ctermbg=NONE guibg=NONE
       let g:airline#extensions#tabline#enabled = 1
       let g:airline_powerline_fonts = 1
       let g:airline#extensions#ale#enabled =  1
       '';
    }
  )
    ];
}
