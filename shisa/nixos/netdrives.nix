{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/run/media/pandy/kageps2" =
    { device = "//192.168.1.96/kageps2";
      fsType = "cifs";
      options = [ "credentials=/etc/nixos/smb-secrets" "rw" "uid=1000" "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
    };
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
  #fileSystems."/home/pandy/.local/share/Steam/steamapps/compatdata/1809540/pfx/drive_c/users/steamuser/AppData/LocalLow/RedCandleGames/NineSols/saveslot0" = {
  #  device = "192.168.1.96:/home/jojess/game/ninesols_saveslot0/";
  #  fsType = "fuse.sshfs";
  #  options = [ "x-systemd.automount" "noauto" "uid=1000" "gid=1000" "user_allow_other" ];
  #};
  security.wrappers."mount.cifs" = {
    program = "mount.cifs";
    source = "${lib.getBin pkgs.cifs-utils}/bin/mount.cifs";
    owner = "root";
    group = "root";
    setuid = true;
    permissions = "u+rx,g+x";
  };
}
