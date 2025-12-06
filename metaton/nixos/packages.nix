{ config, pkgs, ... }:
{

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  users.users.pandy = {
    packages = with pkgs; [
  (pkgs.wrapOBS {
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  })
    alacritty
    appimage-run
    asunder           # cd reader/burner
    audacious         # audio player
    audacity          # audio recorder
    btop              # htop but cooler (?)
    chromium
    deluge
    discord
    dolphin-emu
    efibootmgr        # to modify GRUB
    furnace           # chiptune tracker
    gallery-dl        # mass image downloader
    gimp-with-plugins # picture editor
    heroic            # game launcher (GOG, Epic, Amazon)
#    hyprpaper
#    hyprshot
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
    screenkey         # app that visualizes keystrokes
    scdl              # soundcloud audio downloader
    spotify
    telegram-desktop
    thunderbird
    xdg-desktop-portal
    winetricks
    wireguard-tools
#    cheese           # camera preview and taker
    legendary-gl     # Epic games launcher
    rare             # gui for legendary
#    osu-lazer
    prismlauncher    # some minecraft thing?
    pokemon-colorscripts-mac
    ranger           # vim-like cli file explorer
    (wineWow64Packages.full.override {
      wineRelease = "staging";
      mingwSupport = true;
    }) 
#    (retroarch.override {
#      cores = with libretro; [
#        desmume
#        dolphin
#        genesis-plus-gx
#        pcsx2
#	mgba
#        snes9x
#        beetle-psx-hw
#        nestopia
#      ];
#    })
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.commit-mono
      nerd-fonts.departure-mono
  ];

  programs = {
# Install firefox.
    firefox.enable = true;
    dconf.enable = true;
    #hyprland.enable = true;
    #hyprland.xwayland.enable = true;
    thunar.enable = true;
    appimage.binfmt = true;
# sway.enable = true;
    light.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;
  nixpkgs.config.permittedInsecurePackages = [
    "mbedtls-2.28.10"
    "electron-36.9.5"

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
    brightnessctl
    exiftool
    ffmpeg
    gh
    git
    gnome-tweaks
    gnomeExtensions.appindicator
    hyfetch
    inetutils
    killall
    libheif
    lshw
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
    xournalpp
    zenity
    zip
#    home-manager
    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ale vim-airline vim-airline-themes ];
        opt = [];
      };
      vimrcConfig.customRC = ''
         set mouse=a
         colorscheme elflord
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
