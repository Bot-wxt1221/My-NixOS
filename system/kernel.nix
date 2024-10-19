{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  hardware.firmware = [ pkgs.linux-firmware ];
}
