{ config, lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
#    ./hyprland.nix
    ./waybar.nix
    ./swaylock.nix
    ./swaync.nix
    ./clipboard.nix
  ];
}
