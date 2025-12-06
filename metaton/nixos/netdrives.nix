{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/mnt/kageneko" = {
    device = "192.168.1.96:/";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
  fileSystems."/mnt/kagesuper" = {
    device = "192.168.1.96:/media/kagesuper";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
  fileSystems."/mnt/kagebin" = {
    device = "192.168.1.96:/media/kagebin";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
  fileSystems."/mnt/kumoneko" = {
    device = "192.168.1.96:/media/kumoneko";
    fsType = "nfs";
    options = [ "x-systemd.automount" "noauto" ];
  };
  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
    permissions = "u+rx,g+x";
  };
}
