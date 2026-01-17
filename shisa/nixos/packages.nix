{ config, pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
    "electron-36.9.5"
    "mbedtls-2.28.10"
  ];

  qt.style = "adwaita-dark";

  users.users.pandy = {
    packages = with pkgs; [
  (pkgs.writeShellScriptBin "Discord" ''
    exec ${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
  '')
#  (pkgs.writeShellScriptBin "spotify" ''
#    exec ${pkgs.spotify}/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
#  '')
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  })
    (discord.override {
      # withOpenASAR = true; # can do this here too
      withVencord = true;
    })
    alacritty
    appimage-run
    asunder           # cd reader/burner
    audacious         # audio player
    audacity          # audio recorder
    btop              # htop but cooler (?)
    chromium
    deluge
    dolphin-emu
    efibootmgr        # to modify GRUB
    furnace           # chiptune tracker
    gallery-dl        # mass image downloader
    gimp-with-plugins # picture editor
    heroic            # game launcher (GOG, Epic, Amazon)
    libreoffice       # MS Office replacement
#    lightdm
    lmms              # digital audio workstation
    mullvad-vpn
    nom
    nvtopPackages.amd
    pcsx2
    picard            # audio file metadata tagging
    playerctl         # media player controller
    pulseaudio        # needed for my extra audio controls
    shellcheck        # to validate bash scripts
    screenkey         # app that visualizes keystrokes
    scdl              # soundcloud audio downloader
    spotify
    telegram-desktop
    thunderbird
    winetricks
    wireguard-tools
#    cheese           # camera preview and taker
    legendary-gl     # Epic games launcher
    rare             # gui for legendary
#    osu-lazer
    prismlauncher    # CHICKEN JOCKEYYY!!!
    pokemon-colorscripts-mac
    ranger           # vim-like cli file explorer
    webcord
    wofi
    (wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    }) 
    ];
  };

  fonts.packages = [
    pkgs.nerd-fonts.departure-mono
    pkgs.nerd-fonts.commit-mono
  ];

  # create link to path
  environment.pathsToLink = [ "/libexec" ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    exiftool
    ffmpeg
    gh
    git
    gnome-tweaks
    gnomeExtensions.appindicator
    greetd.tuigreet
    gtk2
    hyfetch
    inetutils
    killall
    libheif
    lshw
    man-db
    mplayer
    mpv
    ncftp
    neovim
    networkmanagerapplet
    orchis-theme
    pavucontrol
    ffmpegthumbnailer
    rename
    tmux
    unrar
    unzip
    usbutils
    vlc
    waybar
    wget
    wl-clipboard
    xclip
    xorg.xev
    xorg.xhost
    xournalpp
    xsecurelock
    zenity
    zip
    home-manager
  ];
  programs = {
    firefox.enable = true;
    dconf.enable = true;
    thunar.enable = true;
    appimage.binfmt = true;
    sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        grim            # screenshot functionality
        libappindicator # enable tray maybe
        slurp           # screenshot functionality
        swaylock        # i3lock
        wl-clipboard    # wl-copy and wl-paste for copy/paste from stdin / stdout
        mako            # notification system developed by swaywm maintainer
        wev
        glib            # so gsettings works
        nautilus
        blueman
      ];
      extraSessionCommands = ''
        export QT_QPA_PLATFORMTHEME=qt6ct
        export CLUTTER_BACKEND=wayland
        export SDL_VIDEODRIVER=wayland
        export XDG_SESSION_TYPE=wayland
        export XDG_CURRENT_DESKTOP=sway
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        export MOZ_ENABLE_WAYLAND=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        export ECORE_EVAS_ENGINE=wayland_egl
        export ELM_ENGINE=wayland_egl
        export #QT_STYLE_OVERRIDE=adwaita-dark
        export NIXOS_OZONE_WL=1
      '';
    };
    light.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
