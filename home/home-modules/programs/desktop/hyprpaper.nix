{
  config,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home = {
    file.".config/hypr/wallpaper.png".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/33856d7837cb8ba76c4fc9e26f91a659066ee31f/wallpapers/nix-wallpaper-nineish-catppuccin-latte-alt.png";
      hash = "sha256-UyUQ4YQYlJrjoUX6qU6cGWjhA1AnIpQgniQermUtO2w=";
    };
    packages = with pkgs; [ hyprpaper ];
  };
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [ "${config.home.homeDirectory}/.config/hypr/wallpaper.png" ];
        wallpaper = [ ",${config.home.homeDirectory}/.config/hypr/wallpaper.png" ];
      };
      package = pkgs.hyprpaper;
    };
  };
}
