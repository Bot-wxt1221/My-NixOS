{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./network
    ./security
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
      "networkmanager"
      "vboxsf"
    ];
    packages = with pkgs; [ ];
  };
}
