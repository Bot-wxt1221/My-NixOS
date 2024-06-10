{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  environment.systemPackages = with pkgs; [
    dconf
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnomeExtensions.gsconnect
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-panel
  ]; 
}