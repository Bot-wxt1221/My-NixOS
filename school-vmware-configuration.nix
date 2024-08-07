{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware/school-vmware.nix
    ./network
    ./security
    ./printing.nix
    ./font.nix
    ./programs
    ./system
  ];
  time.timeZone = "Asia/Shanghai";
  Enablepulseaudio = true;
  Ownhostname = "wxt-school-vmware";
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "adbusers"
      "video"
    ];
    packages = with pkgs; [ ];
  };
}
