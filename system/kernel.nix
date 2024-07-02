{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
  environment.systemPackages = with pkgs;[
    linuxKernel.packages.linux_zen.cpupower
  ];
}
