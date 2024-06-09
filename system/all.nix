{ config, lib, pkgs, ... }:
{
  imports = [
    ./grub.nix
    ./kernel.nix
    ./audio.nix
    ./libinput.nix
    ./console.nix 
  ];
}
