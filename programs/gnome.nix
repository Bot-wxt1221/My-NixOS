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
  xdg.mimeApps = let
    br = "microsoft-edge.desktop";
    fm = "org.gnome.Nautilus.desktop";
    iv = "microsoft-edge.desktop";
    mp = "microsoft-edge.desktop";
    te = "nvim.desktop";
  in rec {
    enable = true;
    associations.added = defaultApplications;
    defaultApplications = {
      # Office documents.
      "application/pdf" = br;

      "inode/directory" = fm;

      # Web stuff.
      "application/xhtml+xml" = br;
      "text/html" = br;
      "x-scheme-handler/http" = br;
      "x-scheme-handler/https" = br;

      # Images.
      "image/avif" = iv;
      "image/gif" = iv;
      "image/jpeg" = iv;
      "image/jpg" = iv;
      "image/pjpeg" = iv;
      "image/png" = iv;
      "image/tiff" = iv;
      "image/webp" = iv;
      "image/x-bmp" = iv;
      "image/x-gray" = iv;
      "image/x-icb" = iv;
      "image/x-ico" = iv;
      "image/x-png" = iv;

      # Plain text & code.
      "application/x-shellscript" = te;
      "text/plain" = te;

      # Videos.
      "video/mkv" = mp;
      "video/mp4" = mp;
      "video/webm" = mp;
    };
  };
}
