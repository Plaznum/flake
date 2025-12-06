# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware.nix
    ./hosts.nix
    ./netdrives.nix
    ./packages.nix
    ./work.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
#  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  boot.extraModulePackages = [ 
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  # to autoload at boot:
  boot.kernelModules = [ 
    "gcadapter_oc"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable flakes!!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # --options--
  # gnome
  # gnome-xorg
  # xfce+i3
  # xfce
  # none+i3
  # hyprland
  services.displayManager.defaultSession = "none+i3";

#  security.pam.services.gdm.enableGnomeKeyring = true;
# Enable the GNOME Desktop Environment.
  services.xserver = {
# Enable the X11 windowing system.
    enable = true;
    displayManager = {
##Graphical session to pre-select in the session chooser (only effective for GDM, LightDM and SDDM).
##On GDM, LightDM and SDDM, it will also be used as a session for auto-login.
##Set this option to empty string to get an error with a list of currently available sessions.
#      lightdm = {
#        # enable = true;
#        background = "/usr/bin/tHYJ136.jpg";
#        greeters.gtk.extraConfig = 
#        ''
#          [Seat:*]
#          greeter-setup-script=/usr/bin/greeter_monitor.sh
#          xserver-command=X -s 0 -dpms
#        '';
#        greeter.enable = true;
#        greeters.slick = { 
#          enable = true;
#        };
#      };
#      gdm = { 
#        enable = true;
#        wayland = false;
#        #wayland = true;
#      };
    };

    desktopManager = {
#      gnome.enable = true;
#      plasma6.enable = true;
      xterm.enable = false;
#      xfce = {
#        enable = true;
#        noDesktop = true;
#        enableXfwm = false;
#      };
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
          #brightnessctl        # screen brightness contoller
          #clipit               # GTK clipboard manager
          #dmenu                # application launcher most people use
          #flameshot            # another screenshot utility
          #i3blocks             # another status bar
          #pasystray            # clipboard manager i think
          #redshift             # color temp manager (like flux)
          blueman               # bluetooth manager
          dunst                 # notification manager
          feh                   # wallpaper handler and pic viewer
#          i3lock                # default i3 screen locker
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
      ];
    };

# Load nvidia driver for Xorg and Wayland
#    videoDrivers = ["nvidia"];
# Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.udev.packages = with pkgs; [ 
    dolphin-emu
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable shitty nvidia drivers
  # Enable OpenGL
#  hardware.graphics = {
#    enable = true;
#  };
#
#  hardware.nvidia = {
#    # Modesetting is required.
#    modesetting.enable = true;
#    powerManagement.enable = false;
#    powerManagement.finegrained = false;
#    open = false;
#    nvidiaSettings = true;
#    package = config.boot.kernelPackages.nvidiaPackages.stable;
#    #package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
#  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
#  hardware.pulseaudio.support32Bit = true;
  hardware.bluetooth.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;

  # VIM setup!
  environment.variables = { EDITOR = "vim"; };
  # More shell stuff idk
   environment.sessionVariables = {
      NIX_SHELL_PRESERVE_PROMPT=1;
   };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.i3lock.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # Thunar addons
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   services.openssh.settings.X11Forwarding = true;
   services.openssh.extraConfig = 
     ''
     AcceptEnv LANG LANGUAGE LC_*
     ''
     ;
  # Enable the mullvad VPN daemon.
   services.mullvad-vpn.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;
   networking.firewall.checkReversePath = false;

   users.users.pandy = {
     isNormalUser = true;
     description = "Pandy!";
     extraGroups = [ "networkmanager" "wheel" "lovely" ];
   };

  # NOPASSWD
   security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
