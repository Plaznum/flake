{ config, pkgs, ... }:
let
  color = "#875faf";
in
{
  home.username = "pandy";
  home.homeDirectory = "/home/pandy";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.tmux

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pandy/etc/profile.d/hm-session-vars.sh
  #
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
      alias hmswitch="home-manager switch --flake ~/test/home-manager/"
      alias rebuild="sudo nixos-rebuild switch --flake ~/test/#test"
    '';
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
      set -g pane-active-border-style 'fg=${color}'
      set -g status-style 'fg=${color}'
      set -g status-position 'top'
      set-option -g default-command bash
      setw -g pane-base-index 1
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
      let g:airline_theme = 'owo'
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git.enable = true;
  systemd.user.startServices = "sd-switch";
}
