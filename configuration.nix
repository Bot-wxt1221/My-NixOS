# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, nixpkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./network
      ./hardware/g3.nix
      ./security
      ./printing.nix
      ./font.nix
      ./programs
      ./system
    ];
  time.timeZone = "Asia/Shanghai";
  users.users.wxt = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "adbusers" "libvirtd"];
    packages = with pkgs; [
    ];  
  };
}
