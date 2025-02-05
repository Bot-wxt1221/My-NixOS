{
  config,
  lib,
  pkgs,
  niri,
  ...
}:
{
  imports = [
    ./hyprpaper.nix
    ./niri.nix
    ./waybar.nix
    ./swaync.nix
    #    ./clipboard.nix
  ];
}
