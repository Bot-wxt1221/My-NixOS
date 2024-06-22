{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
