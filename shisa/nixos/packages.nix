{ config, pkgs, ... }:
{

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-33.4.11"
    "mbedtls-2.28.10"
  ];

  qt.style = "adwaita-dark";

  users.users.pandy = {
    packages = with pkgs; [
#  (pkgs.writeShellScriptBin "Discord" ''
#    exec ${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland
#  '')
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
    uwsm
    xdg-desktop-portal
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

    # i3
    #brightnessctl        # screen brightness contoller
    #clipit               # GTK clipboard manager
    #dmenu                # application launcher most people use
    #flameshot            # another screenshot utility
    #i3blocks             # another status bar
    #pasystray            # clipboard manager i think
    #redshift             # color temp manager (like flux)
    dunst                 # notification manager
    feh                   # wallpaper handler and pic viewer
    i3lock                # default i3 screen locker
    i3status              # gives you the default i3 status bar
    ibus                  # input handler manager
    #lxappearance         # appearance manager gui
    maim                  # screenshot utility
    networkmanagerapplet  # self explanitory
    picom                 # compositor. aesthetic window stuff
    polybarFull           # bar that's hard to use
    rofi                  # run dialog (does some other stuff too)
    xorg.setxkbmap
    xorg.xinput
    xss-lock

    # hyprland only
    hyprpaper
    hyprshot

    (wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    }) 
    #(retroarch.override {
    #  cores = with libretro; [
    #    desmume
    #    dolphin
    #    genesis-plus-gx
    #    pcsx2
	 #    mgba
    #    snes9x
    #    beetle-psx-hw
    #    nestopia
    #  ];
    #})
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
    #These are all for Plasma6/KDE
#    kdePackages.discover         # Optional: Install if you use Flatpak or fwupd firmware update sevice
#    kdePackages.kcalc            # Calculator
#    kdePackages.kcharselect      # Tool to select and copy special characters from all installed fonts
#    kdePackages.kcolorchooser    # A small utility to select a color
#    kdePackages.kolourpaint      # Easy-to-use paint program
#    kdePackages.ksystemlog       # KDE SystemLog Application
#    kdePackages.sddm-kcm         # Configuration module for SDDM
#    kdiff3                       # Compares and merges 2 or 3 files or directories
#    kdePackages.isoimagewriter   # Optional: Program to write hybrid ISO files onto USB disks
#    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
#    hardinfo2                    # System information and benchmarks for Linux systems
#    haruna                       # Open source video player built with Qt/QML and libmpv
#    wayland-utils                # Wayland utilities
#    wl-clipboard                 # Command-line copy/paste utilities for Wayland
    exiftool
    ffmpeg
    gh
    git
    gnome-tweaks
    gnomeExtensions.appindicator
    greetd.tuigreet
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
    pkgs.ffmpegthumbnailer
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


#    home-manager
#  environment.gnome.excludePackages = with pkgs; [
#    # an attempt to stop keyring BS
#    gnome-keyring
#  ];
  ];
  programs = {
    firefox.enable = true;
    dconf.enable = true;
    hyprland.enable = true;
    hyprland.withUWSM = true;
    hyprland.xwayland.enable = true;
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
      extraOptions = [
        "--unsupported-gpu"
      ];
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
