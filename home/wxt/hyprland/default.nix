{ config, lib, pkgs, ... }:
{
  imports = [
    ./hyprpaper.nix
#    ./hyprland.nix
    ./waybar.nix
    ./swaync.nix
    ./clipboard.nix
  ];
  home.packages = with pkgs;[hyprlock];
}
