{
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}:

{
  imports = [ ./school-vmware-hardware-configuration.nix ];
  environment.systemPackages = with pkgs; [
    xorg.xf86videovmware
  ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
    ];
  };
}
