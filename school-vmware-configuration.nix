{
  config,
  lib,
  pkgs,
  pkgs-main,
  hyprland,
  ...
}:
{
  imports = [
    ./hardware/school-vmware.nix
    ./network
    ./security
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Ownhostname = "wxt-school-vmware";
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "video"
      "networkmanager"
    ];
    packages = with pkgs; [ ];
  };
  services.turn-rs = {
    enable = true;
    settings = {
      extraConfig = ''
        [[turn.interfaces]]
        transport = "udp"
        bind = "127.0.0.1:3478"
      '';
    };
  };
}
