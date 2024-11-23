{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".config/hypr/wallpaper.png".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nixos-wallpaper-catppuccin-latte.png";
    hash = "sha256-Y6WCwmHOLBStj1D9mcU2082y1fhAFHna01ajfUHxehk=";
  };
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    preload = [ "${config.home.homeDirectory}/.config/hypr/wallpaper.png" ];
    wallpaper = [ ",${config.home.homeDirectory}/.config/hypr/wallpaper.png" ];
  };
  services.hyprpaper.package = pkgs.hyprpaper;
  home.packages = with pkgs; [ hyprpaper ];
}
