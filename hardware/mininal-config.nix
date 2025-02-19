{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [
    ./mininal-hardware-config.nix
    ./persist-config.nix
  ];
  environment.systemPackages = with pkgs; [
    xorg.xf86videovmware
  ];
  hardware.graphics = {
    enable = true;
  };
}
