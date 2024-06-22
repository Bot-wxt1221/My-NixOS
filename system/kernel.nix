{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = linuxKernel.kernels.linux_zen;
  environment.systemPackages = with pkgs; [
    linuxKernel.kernels.linux_zen
  ];
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
