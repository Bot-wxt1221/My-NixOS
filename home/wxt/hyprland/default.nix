{ config, lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
#    ./hyprland.nix
    ./waybar.nix
    ./swaync.nix
    ./wofi.nix
    ./hyprlock.nix
    ./clipboard.nix
  ];
}
