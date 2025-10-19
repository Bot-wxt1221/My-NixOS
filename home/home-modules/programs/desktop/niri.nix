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
    patches = old.patches or [ ] ++ [
      ./wlr.patch
    ];
    buildInputs = old.buildInputs ++ [
      pkgs.libxkbcommon
    ];
    src = pkgs.fetchFromGitHub {
      owner = "emersion";
      repo = "xdg-desktop-portal-wlr";
      rev = "b3703cceea485972b139c22342bdc2ed7b80c1c2";
      hash = "sha256-nFAp/9ofRH4kIFgg2SjzZNXYu8r0BBjO5VPFc3jKeas=";
    };
  });
  xdg-desktop-portal-for-rustdesk = pkgs.xdg-desktop-portal.overrideAttrs (old: {
    postPatch = old.postPatch + ''
      substituteInPlace src/xdg-desktop-portal.c \
        --replace-fail "org.freedesktop.portal.Desktop" "org.freedesktop.portal.Desktop-for-rustdesk"
    '';
    doCheck = false;
  });
in
{
  imports = [
    ./clipboard.nix
  ];
  config = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "${lib.getExe pkgs.zsh}";
        };
      };
    };
    home.packages = with pkgs; [
      xsel
      pkgs.swaylock-effects
      clipboard.packages."x86_64-linux".default
      glib.bin
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
        gnome-keyring
        xdg-desktop-portal-gtk
        xdg-desktop-portal
      ];
      config = {
        niri = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.RemoteDesktop" = [ "gnome" ];
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
        };
      };
      xdgOpenUsePortal = true;
    };
    systemd.user.services.xdg-desktop-portal-for-rustdesk = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "xdg-desktop-portal-for-rustdesk";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        Environment = [
          "XDG_DESKTOP_PORTAL_DIR=${./xdg-rustdesk-dir/xdg-desktop-portal/portals}"
        ];
        ExecStart = "${xdg-desktop-portal-for-rustdesk}/libexec/xdg-desktop-portal";
        Restart = "on-failure";
        RestartSec = "10";
      };
    };

    programs.niriswitcher = {
      enable = true;
      settings = {
        keys = {
          modifier = "Super";
          switch = {
            next = "Tab";
            prev = "Shift+Tab";
          };
        };
        center_on_focus = true;
        appearance = {
          system_theme = "dark";
          icon_size = 64;
        };
      };
      style = ''
        .application-name {
          opacity: 1;
          color: rgba(255, 255, 255, 0.6);
        }
        .application.selected .application-name {
          color: rgba(255, 255, 255, 1);
        }
      '';
    };
    systemd.user.services.niriswitcher = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "niriswitcher";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.niriswitcher}";
        Restart = "on-failure";
        RestartSec = "10";
      };
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
        br = "firefox-beta.desktop";
        fm = "org.gnome.Nautilus.desktop";
        iv = "firefox-beta.desktop";
        mp = "firefox-beta.desktop";
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
      (pkgs.replaceVars ./niri.kdl {
        swaylockscript = pkgs.writeText "a.sh" ''
          ${lib.getExe pkgs.swaylock-effects} --screenshots --clock --font "WenQuanYi Micro Hei" --effect-pixelate 20 --effect-greyscale --effect-vignette 0.7:0.7
        '';
        startClashVerge = pkgs.writeText "a.sh" ''
          sleep 5
          systemctl restart --user waybar
          sleep 5
          clash-verge
        '';
      }).overrideAttrs
        {
          doCheck = false;
        }
    );
  };
}
