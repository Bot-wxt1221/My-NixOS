{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxKernel.kernels.linux_zen_latest;
  environment.systemPackages = with pkgs; [
    pkgs.linuxKernel.kernels.linux_zen_latest
  ];
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
