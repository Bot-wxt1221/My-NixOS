{ config, lib, pkgs, ... }:
{
  imports = [
    ./grub.nix
    ./kernel.nix
    ./audio-pipewire.nix
    ./audio-pulse.nix
    ./console.nix 
  ];
}
