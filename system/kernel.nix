{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen;
  environment.systemPackages = with pkgs; [
    pkgs.linuxKernel.kernels.linux_zen
  ];
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
