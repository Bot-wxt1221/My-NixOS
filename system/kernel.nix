{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_stable;
  hardware.firmware = [ pkgs.linux-firmware ];
}
