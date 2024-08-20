{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [ ./school-vmware-hardware-configuration.nix ];
}
