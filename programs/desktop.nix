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
    gnome-system-monitor
  ];
  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  programs.light.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.gnome-disks.enable = true;
  services.udisks2.enable = true;
  services.udisks2.mountOnMedia = true;
}
