{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [ ./school-vmware-hardware-configuration.nix ];
  virtualisation.vmware.guest.enable = true;
  services.xserver.videoDrivers = [ "vmware" ];
}
