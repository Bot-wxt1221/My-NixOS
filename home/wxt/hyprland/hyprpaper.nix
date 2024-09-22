{
  config,
  lib,
  pkgs,
  pkgs-main,
  ...
}:
{
  imports = [

  ];
  home.file.".config/hypr/wallpaper.svg".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nixos-wallpaper-catppuccin-latte.svg";
    hash = "sha256-rR2XXN82UBPPxWoLn5DppZO8ei9m8nrO/y3VxSKDP2k=";
  };
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "${config.home.homeDirectory}/.config/hypr/wallpaper.svg" ];
    wallpaper = [ ",${config.home.homeDirectory}/.config/hypr/wallpaper.svg" ];
  };
  services.hyprpaper.package = pkgs.hyprpaper;
  home.packages = with pkgs; [ hyprpaper ];
}
