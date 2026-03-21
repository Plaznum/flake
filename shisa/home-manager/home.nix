{ config, pkgs, ... }:
{
  imports = [
    ./neovim.nix
    ./sway.nix
    ./vim.nix
    ./tmux.nix
    ./bash.nix
  ];
  home.username = "pandy";
  home.homeDirectory = "/home/pandy";

  home.stateVersion = "25.11"; # Please read the comment before changing.

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    #settings = {
    #  user = {
    #    name = "Plaznum";
    #    email = "rycs1997@gmail.com";
    #  };
    #};
  };
  systemd.user.startServices = "sd-switch";
}
