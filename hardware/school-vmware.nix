{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [ ./school-vmware-hardware-configuration.nix ];
  virtualisation.virtualbox.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];
}
