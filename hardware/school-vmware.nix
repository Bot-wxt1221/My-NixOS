{
  config,
  lib,
  pkgs,
  nixos-facter-modules,
  ...
}:

{
  imports = [
    ./school-vmware-hardware-configuration.nix
    ./persist-config.nix
    nixos-facter-modules.nixosModules.facter
  ];
  facter.reportPath = ./facter-school-vmware.json;
  environment.systemPackages = with pkgs; [
    xorg.xf86videovmware
  ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
    ];
  };
  virtualisation.vmware.guest.enable = true;
}
