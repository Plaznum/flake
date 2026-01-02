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

  boot.kernelModules = [ 
    "gcadapter_oc"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.networkmanager.enable = true;
  time.timeZone = "America/New_York";

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
    desktopManager = {
      xterm.enable = false;
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

# Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.udev.packages = with pkgs; [ 
    dolphin-emu
  ];

  services.printing.enable = true;
  services.libinput.enable = true;
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

   environment.variables = { 
     EDITOR = "vim"; 
     XSECURELOCK_PASSWORD_PROMPT = "asterisks";
     # get themes working with sway...
     QT_QPA_PLATFORMTHEME = "qt6ct";
     CLUTTER_BACKEND = "wayland";
     SDL_VIDEODRIVER = "wayland";
     XDG_SESSION_TYPE = "wayland";
     XDG_CURRENT_DESKTOP = "sway";
     QT_QPA_PLATFORM = "wayland";
     QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
     MOZ_ENABLE_WAYLAND = "1";
     _JAVA_AWT_WM_NONREPARENTING = "1";
     ECORE_EVAS_ENGINE = "wayland_egl";
     ELM_ENGINE = "wayland_egl";
     #QT_STYLE_OVERRIDE = "adwaita-dark";
     NIXOS_OZONE_WL = "1";
     NIX_SHELL_PRESERVE_PROMPT= "1";
   };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.i3lock.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

   services.gvfs.enable = true; # Mount, trash, and other functionalities
   services.tumbler.enable = true; # Thumbnail support for images
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
   security.sudo.wheelNeedsPassword = false;
   system.stateVersion = "24.05"; # Did you read the comment?
}
