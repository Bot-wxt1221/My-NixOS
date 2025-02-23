{
  config,
  lib,
  pkgs,
  clipboard,
  ...
}:
let
  wlr-xdg-desktop = (
    pkgs.xdg-desktop-portal-wlr.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "emersion";
        repo = "xdg-desktop-portal-wlr";
        rev = "d9ada849aeca6137915de2df69beaef4e272cc1d";
        hash = "sha256-Vuf7bRAWozcA6mdR/h4YDCb9e14JMBL6uLXGkNWJ5KE=";
      };
      patches = (old.patches or [ ]) ++ [ ../../../325.patch ];
      buildInputs = (old.buildInputs or [ ]) ++ [
        pkgs.libxkbcommon
      ];
    })
  );
in
{
  imports = [
  ];
  options = {
    audioProcess = lib.mkOption {
      type = lib.types.str;
      default = "";
    };
  };
  config = {
    home.packages = with pkgs; [
      fuzzel
      xsel
      pkgs.swaylock-effects
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
        wlr-xdg-desktop
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      extraPortals = [
        wlr-xdg-desktop
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      config = {
        niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "wlr" ];
        };
      };
      xdgOpenUsePortal = true;
    };
    home.activation.mimeapps-remove = lib.hm.dag.entryBefore [
      "checkLinkTargets"
    ] ''rm -f ${config.home.homeDirectory}/.config/mimeapps.list'';
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
    xdg.configFile."niri/config.kdl".text = builtins.readFile (
      pkgs.substituteAll {
        src = ./niri.kdl;
        authAgent = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        startXwayland = pkgs.writeText "a.sh" ''
          sleep 3
          xwayland-satellite :0
        '';
        startClashVerge = pkgs.writeText "a.sh" ''
          sleep 5
          clash-verge
        '';
        swaylockscript = pkgs.writeText "a.sh" ''
          niri msg action power-off-monitors
          ${lib.getExe pkgs.swaylock-effects} --screenshots --clock --font "WenQuanYi Micro Hei"
        '';
        SetupAudio = pkgs.writeText "a.sh" config.audioProcess;
      }
    );
  };
}
