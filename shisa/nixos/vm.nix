{pkgs, ...}: {
  boot.extraModprobeConfig = "options kvm_intel nested=1";
  users.users.pandy = {
    extraGroups = [ "libvirtd" ];
    packages = with pkgs; [
      virt-manager
    ];
  };
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = { # not needed in NixOS 25.11 since https://github.com/NixOS/nixpkgs/pull/421549
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };
  virtualisation.spiceUSBRedirection.enable = true;
#  virtualisation.vmware.host.enable = true;
#  virtualisation.virtualbox.host.enable = true;
#  users.extraGroups.vboxusers.members = [ "pandy" ];
}
