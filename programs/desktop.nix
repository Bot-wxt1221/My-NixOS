{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    dconf
    gnome-terminal
    gnome-tweaks
  ];
  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
}
