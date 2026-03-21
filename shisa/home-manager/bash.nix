{ config, lib, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoreboth" ];
    historyFileSize = 100000;
    historySize = 10000;
    enableCompletion = true;
    bashrcExtra = ''
      PS1='\[\e[38;5;17;48;5;177;1m\]\u@\h:\[\e[0;38;5;177;48;5;17m\]\w\\$\[\e[0m\] '
      motd
    '';
    shellAliases = {
      hmswitch = "home-manager switch --flake ~/flake/shisa/";
      rebuild = "sudo nixos-rebuild switch --flake ~/flake/shisa/#shisa";
      bofa = "rebuild; hmswitch";
      la = "ls -lrta";
      cmit = "git commit -m";
      cvs = "git";
    };
  };
}
