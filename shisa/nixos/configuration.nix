{ config, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
    ./gpu.nix
    ./hardware.nix
    ./hosts.nix
    ./netdrives.nix
    ./packages.nix
    ./vim.nix
    ./motd.nix
#    ./vm.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
#  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  boot.extraModulePackages = [ 
    config.boot.kernelPackages.gcadapter-oc-kmod
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  # to autoload at boot:
  boot.kernelModules = [ 
    "gcadapter_oc"
  ];
#  boot.kernelParams = [
#    "video=HDMI-1:1920x1080@60"
#    "video=DP-2:1920x1080@144"
#    "video=DP-3:1920x1080@60"
#  ];

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
  services.displayManager.defaultSession = "sway";
  #services.displayManager.ly.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.displayManager.sddm.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
  services.xserver = {
# Enable the X11 windowing system.
    enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager = {
      lightdm = { 
        enable = true;
      };
    };

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
      ];
    };

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  xdg.autostart.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
    config = {
      sway = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.OpenURI" = "gtk";
        "org.freedesktop.impl.portal.Screencast" = "wlr";
        "org.freedesktop.impl.portal.Screenshot" = "wlr";
        "org.freedesktop.impl.portal.GlobalShortcuts" = "gtk";
      };
    };
  };

  services.udev.packages = with pkgs; [ 
    dolphin-emu
    gnome-settings-daemon
  ];
  services.printing.enable = true;
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

   environment.variables = { 
     # VIM setup!
     EDITOR = "vim"; 
     XSECURELOCK_PASSWORD_PROMPT = "asterisks"; 
     NIX_SHELL_PRESERVE_PROMPT = "1";
   };
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.openssh.enable = true;
#   services.openssh.settings.X11Forwarding = true;
  services.mullvad-vpn.enable = true;
  services.gnome.gnome-keyring.enable = true;

#  services.greetd = {                                                      
#    enable = true;                                                         
#    settings = {                                                           
#      default_session = {                                                  
#        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
#        user = "pandy";                                                  
#      };                                                                   
#    };                                                                     
#  };

   networking.firewall.allowedTCPPorts = [ 57621 ];
   networking.firewall.allowedUDPPorts = [ 5353 ];

   users.users.pandy = {
     isNormalUser = true;
     description = "Pandy!";
     extraGroups = [ "networkmanager" "wheel" "lovely" ];
   };
   # NOPASSWD
   security.sudo.wheelNeedsPassword = false;
   security.polkit.enable = true;
   system.stateVersion = "24.05"; # Did you read the comment?

}
