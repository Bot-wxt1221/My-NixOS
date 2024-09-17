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
    ./font.nix
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
}
