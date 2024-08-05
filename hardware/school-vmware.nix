{ config, lib, pkgs, nixpkgs,... }:

{
  imports =
    [
      ./school-vmware-hardware-configuration.nix
    ];
}
# even though nothing here. We should keep this if we need it.
