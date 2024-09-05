{
  config,
  lib,
  pkgs,
  pkgs-main,
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
  services.xserver.desktopManager.gnome.enable = true;

}
