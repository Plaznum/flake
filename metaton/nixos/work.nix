{ config, pkgs, ... }:
{
  users.users.pandy = {
    packages = with pkgs; [
      slack
      onedrive
      chromium
    ];
  };
  services.openvpn.servers = {
    ULEVPN  = { config = '' config /root/nixos/openvpn/rcrews2.conf ''; };
    ULWVPN  = { config = '' config /root/nixos/openvpn/rcrews2-west.conf ''; };
  };
  programs.ssh.extraConfig = ''
    Host muad muad-dev
    HostName 172.31.34.244
    User rcrews
  '';
}
# on uninstall
# $ sudo rm -rf ~/OneDrive/
# $ sudo rm -rf /root/nixos/
