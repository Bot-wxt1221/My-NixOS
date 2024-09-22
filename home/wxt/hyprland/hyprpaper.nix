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
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "${config.home.homeDirectory}/.config/hypr/wallpaper.svg" ];
    wallpaper = [ ",${config.home.homeDirectory}/.config/hypr/wallpaper.svg" ];
  };
  services.hyprpaper.package = pkgs.hyprpaper;
  home.packages = with pkgs; [ hyprpaper ];
}
