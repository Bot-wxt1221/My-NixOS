{
  config,
  lib,
  pkgs,
  pkgs-main,
  hyprland,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./hyprland.nix
    ./waybar.nix
    ./swaync.nix
    ./clipboard.nix
  ];
}
