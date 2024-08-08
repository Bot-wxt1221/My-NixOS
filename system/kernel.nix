{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;
  boot.kernelParams = [ "acpi_osi=Linux-Dell-Video" ];
}
