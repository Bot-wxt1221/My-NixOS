{
  config,
  lib,
  pkgs,
  clipboard,
  osConfig,
  ...
}:
let
  wlr-xdg-desktop = pkgs.xdg-desktop-portal-wlr.overrideAttrs (old: {
    src = pkgs.fetchFromGitHub {
      owner = "emersion";
      repo = "xdg-desktop-portal-wlr";
      rev = "d9ada849aeca6137915de2df69beaef4e272cc1d";
      hash = "sha256-Vuf7bRAWozcA6mdR/h4YDCb9e14JMBL6uLXGkNWJ5KE=";
    };
    patches = (old.patches or [ ]) ++ [ ./325.patch ];
    buildInputs = (old.buildInputs or [ ]) ++ [
      pkgs.libxkbcommon
    ];
  });
in
{
  imports = [
    ./clipboard.nix
  ];
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
        osConfig.niriInUse
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
          "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
        };
      };
      xdgOpenUsePortal = true;
    };
    home.file = {
      ".config/wayvnc/config".text = ''
        enable_auth=true
        enable_pam=true
      '';
    };
    home.activation.mimeapps-remove = lib.hm.dag.entryBefore [
      "checkLinkTargets"
    ] ''rm -f ${config.home.homeDirectory}/.config/mimeapps.list'';
    xdg.mimeApps =
      let
        br = "chromium-browser.desktop";
        fm = "org.gnome.Nautilus.desktop";
        iv = "chromium-browser.desktop";
        mp = "chromium-browser.desktop";
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
    systemd.user.services.agent-polkit = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "agent-polkit";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${pkgs.pantheon.pantheon-agent-polkit}/libexec/policykit-1-pantheon/io.elementary.desktop.agent-polkit";
        Restart = "always";
        RestartSec = "10";
      };
    };
    systemd.user.services.waydroid = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "waydroid";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.waydroid} session start";
        Restart = "on-failure";
        RestartSec = "10";
      };
    };
    systemd.user.services.xwayland-satellite = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        RefuseManualStop = true;
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "xwayland-satellite";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart =
          let
            script = pkgs.writeText "a.sh" ''
              sleep 5
              ${lib.getExe pkgs.xwayland-satellite} :0
            '';
          in
          ''
            ${lib.getExe pkgs.bash} ${script}
          '';
        Restart = "always";
        RestartSec = "10";
      };
    };
    systemd.user.services.wayvnc = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "wayvnc";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.wayvnc} 0.0.0.0";
        Restart = "on-failure";
        RestartSec = "10";
      };
    };

    xdg.configFile."niri/config.kdl".text = builtins.readFile (
      pkgs.substituteAll {
        src = ./niri.kdl;
        swaylockscript = pkgs.writeText "a.sh" ''
          ${lib.getExe pkgs.swaylock-effects} --screenshots --clock --font "WenQuanYi Micro Hei"
        '';
        startClashVerge = pkgs.writeText "a.sh" ''
          sleep 10
          clash-verge
        '';
        overviewScript = pkgs.writeText "a.sh" ''
          echo '{"Action":{"ToggleOverview":{}}}' | comma socat STDIO "$NIRI_SOCKET"
        '';
      }
    );
  };
}
