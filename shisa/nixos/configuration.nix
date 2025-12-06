{ config, pkgs, ... }:
{
  imports = [ # Include the results of the hardware scan.
    ./gpu.nix
    ./hardware.nix
    ./hosts.nix
    ./netdrives.nix
    ./packages.nix
    ./vim.nix
    ./vm.nix
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

  # to autoload at boot:
  boot.kernelModules = [ 
    "gcadapter_oc"
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    displayManager = {
 #     lightdm = {
 #       # enable = true;
 #       background = "/usr/bin/tHYJ136.jpg";
 #       greeters.gtk.extraConfig = 
 #       ''
 #         [Seat:*]
 #         greeter-setup-script=/usr/bin/greeter_monitor.sh
 #         xserver-command=X -s 0 -dpms
 #       '';
 #       greeter.enable = true;
 #       greeters.slick = { 
 #         enable = true;
 #       };
 #     };
      gdm = { 
        enable = true;
        wayland = true;
      };
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
    windowManager.i3.enable = true;

    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.udev.packages = with pkgs; [ 
    dolphin-emu
    gnome-settings-daemon 
  ];
  services.printing.enable = true;
#  hardware.pulseaudio.enable = false;
#  hardware.pulseaudio.support32Bit = true;
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

     # get themes working with sway...
     # custom theming
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
   #networking.firewall.enable = false;
   #networking.firewall.checkReversePath = false;

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
