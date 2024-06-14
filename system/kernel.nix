{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_rt_6_9;
  environment.systemPackages = with pkgs; [
    linuxKernel.kernels.linux_rt_6_9 
  ];
  boot.kernelParams = [
    "acpi_osi=Linux-Dell-Video"
  ];
}
