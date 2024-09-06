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
  programs.hyprland.package = pkgs.hyprland.overrideAttrs(finalAttrs:{
    src = pkgs.fetchFromGitHub {
      owner = "hyprwm";
      repo = finalAttrs.pname;
      fetchSubmodules = true;
      rev = "b0fca6eaf00a2c5061f499c76ec8d60772b6a719";
      hash = "sha256-JmfnYz+9a4TjNL3mAus1VpoWtTI9d1xkW9MHbkcV0Po=";
    };
    }
  );
  programs.hyprland.xwayland.enable = true;
  programs.hyprland.portalPackage = pkgs.xdg-desktop-portal-hyprland;
  programs.light.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.gnome-disks.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
