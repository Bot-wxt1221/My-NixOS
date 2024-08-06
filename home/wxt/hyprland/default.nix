{
  config,
  lib,
  pkgs,
  nix-colors,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./hyprland.nix
    ./waybar.nix
    ./swaync.nix
    ./wofi.nix
    ./clipboard.nix
    nix-colors.homeManagerModules.default
  ];
  colorScheme = nix-colors.colorSchemes.nord;
}
