{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.efiSupport = true;
}
