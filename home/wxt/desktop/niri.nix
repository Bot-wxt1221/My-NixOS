{
  config,
  lib,
  pkgs,
  niri,
  clipboard,
  ...
}:
{
  imports = [
  ];
  home.packages = with pkgs; [
    fuzzel
    xsel
    clipboard.packages.${pkgs.system}.default
  ];
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    x11.defaultCursor = "macOS";
    package = pkgs.apple-cursor;
    name = "macOS";
  };
  xdg.enable = true;
  xdg.portal = with pkgs; {
    enable = true;
    configPackages = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
    extraPortals = [
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
    xdgOpenUsePortal = true;
  };

  xdg.mimeApps =
    let
      br = "microsoft-edge.desktop";
      fm = "org.gnome.Nautilus.desktop";
      iv = "microsoft-edge.desktop";
      mp = "microsoft-edge.desktop";
      te = "nvim.desktop";
    in
    rec {
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
  programs.niri.config = builtins.readFile (
    pkgs.substituteAll {
      src = ./niri.kdl;
      authAgent = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      startXwayland = pkgs.writeText "a.sh" ''
        sleep 3
        xwayland-satellite :0
      '';
      startClashVerge = pkgs.writeText "a.sh" ''
        sleep 5
        clash-verge
      '';
    }
  );
}
