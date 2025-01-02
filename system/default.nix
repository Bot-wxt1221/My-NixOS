{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./grub.nix
    ./kernel.nix
    ./laptop.nix
    ./audio-pipewire.nix
    ./audio-pulse.nix
    ./console.nix
    ./font.nix
    ./printing.nix
    ./etc.nix
    ./bluetooth.nix
  ];
}
