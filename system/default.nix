{ config, lib, pkgs, ... }:
{
  imports = [
    ./grub.nix
    ./kernel.nix
    ./audio-pipewire.nix
    ./audio-pulse.nix
    ./intel.nix
    ./libinput.nix
    ./console.nix 
    ./laptop.nix
  ];
}
