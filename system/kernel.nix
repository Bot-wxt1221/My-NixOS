{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
