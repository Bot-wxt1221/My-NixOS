{ config, lib, pkgs, ... }:
{
  imports = [
    ./grub.nix
    ./kernel.nix
    ./audio.nix
    ./intel.nix
    ./libinput.nix
    ./console.nix 
    ./laptop.nix
  ];
}
