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
  xdg.portal = with pkgs; {
    enable = true;
    configPackages = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xdg-desktop-portal
    ];
    extraPortals = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
    xdgOpenUsePortal = true;
  };
}
