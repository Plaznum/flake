{ config, pkgs, ... }:
let
  color = "#875faf";
# Tokyonight Moon theme colors
  thm_bg="#222436";
  thm_fg="#c8d3f5";
  thm_cyan="#86e1fc";
  thm_black="#1b1d2b";
  thm_gray="#3a3f5a";
  thm_magenta="#c099ff";
  thm_pink="#ff757f";
  thm_red="#ff757f";
  thm_green="#c3e88d";
  thm_yellow="#ffc777";
  thm_blue="#82aaff";
  thm_orange="#ff9e64";
  thm_black4="#444a73";
in
{
  imports = [
#    ./sway.nix
  ];
  home.username = "pandy";
  home.homeDirectory = "/home/pandy";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.tmux
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = ["~/bin"];
  home.sessionVariables = {
    EDITOR = "vim";
  };
  programs.bash = {
    enable = true;
    historyControl = [ "ignoreboth" ];
    historyFileSize = 100000;
    historySize = 10000;
    enableCompletion = true;
    bashrcExtra = ''
      PS1='\[\e[38;5;17;48;5;177;1m\]\u@\h:\[\e[0;38;5;177;48;5;17m\]\w\\$\[\e[0m\] '
    '';
    shellAliases = {
      hmswitch = "home-manager switch --flake ~/flake/shisa/home-manager/";
      rebuild = "sudo nixos-rebuild switch --flake ~/flake/shisa/#shisa";
      bofa = "rebuild; hmswitch";
    };
  };
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    focusEvents = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    prefix = "C-s";
    terminal = "tmux-256color";
    extraConfig = ''
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind P paste-buffer
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel
      set -g pane-active-border-style 'fg=${color}'
      set -g status-style 'fg=${color}'
      set -g status-position 'top'
      set-option -g default-command bash
      setw -g pane-base-index 1
      set -g pane-base-index 1
      set-option -sa terminal-overrides ',*:RGB'
      set -g status-position 'top'
      set-option -g default-command bash

      # Status bar
      set -g status "on"
      set -g status-bg "${thm_bg}"
      set -g status-justify "left"
      set -g status-left-length "100"
      set -g status-right-length "100"

      # Messages
      set -g message-style "fg=${thm_cyan},bg=${thm_gray},align=centre"
      set -g message-command-style "fg=${thm_cyan},bg=${thm_gray},align=centre"

      # Panes
      set -g pane-border-style "fg=${thm_gray}"
      set -g pane-active-border-style "fg=${thm_blue}"

      # Windows
      set -g window-status-activity-style "fg=${thm_fg},bg=${thm_bg},none"
      set -g window-status-separator ""
      set -g window-status-style "fg=${thm_fg},bg=${thm_bg},none"

      # Statusline - current window
      set -g window-status-current-format "#[fg=${thm_blue},bg=${thm_bg}] #I: #[fg=${thm_magenta},bg=${thm_bg}](✓) #[fg=${thm_cyan},bg=${thm_bg}]#(echo '#{pane_current_path}' | rev | cut -d'/' -f-2 | rev) #[fg=${thm_magenta},bg=${thm_bg}]"

      # Statusline - other windows
      set -g window-status-format "#[fg=${thm_blue},bg=${thm_bg}] #I: #[fg=${thm_fg},bg=${thm_bg}]#W"

      # Statusline - right side
      set -g status-right "#[fg=${thm_blue},bg=${thm_bg},nobold,nounderscore,noitalics]#[fg=${thm_bg},bg=${thm_blue},nobold,nounderscore,noitalics] #[fg=${thm_fg},bg=${thm_gray}] #W #{?client_prefix,#[fg=${thm_magenta}],#[fg=${thm_cyan}]}#[bg=${thm_gray}]#{?client_prefix,#[bg=${thm_magenta}],#[bg=${thm_cyan}]}#[fg=${thm_bg}] #[fg=${thm_fg},bg=${thm_gray}] #S "

      # Statusline - left side (empty)
      set -g status-left ""

      # Modes
      set -g clock-mode-colour "${thm_blue}"
      set -g mode-style "fg=${thm_blue} bg=${thm_black4} bold"
    '';
  };
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Plaznum";
        email = "rycs1997@gmail.com";
      };
    };
  };
  systemd.user.startServices = "sd-switch";
}
