{
  pkgs,
  ...
}:

let
  btrfs-desktop-notification = pkgs.stdenv.mkDerivation {
    pname = "btrfs-desktop-notification";
    version = "0-unstable-2025-02-23";

    src = pkgs.fetchFromGitLab {
      owner = "Zesko";
      repo = "btrfs-desktop-notification";
      rev = "58e41fad20499076e0ad6fc3d3521af3d3ec0b67";
      hash = "sha256-wQHDvUAlcpmc3D9NT8U2r1B8xrv5Wqfw7xpznIvJnNc=";
    };

    buildPhase = ''
      runHook preBuild

      mkdir -p $out/bin
      cp -rf usr/bin/* $out/bin
      chmod +x $out/bin/*
      substituteInPlace $out/bin/* \
        --replace-fail "notify-send" "${pkgs.libnotify}/bin/notify-send"

      runHook postBuild
    '';
  };
in

{
  environment.etc."btrfs-desktop-notification.conf".text = ''
    DETECT_RO_SNAPSHOT="yes"

    TIME_INTERVAL="3"

    TERMINAL="konsole"

    LOG_LEVEL="4"

    ERROR_ICON="${pkgs.kdePackages.breeze-icons}/share/icons/breeze/status/24/data-warning.svg"
    INFO_ICON="${pkgs.kdePackages.breeze-icons}/share/icons/breeze/status/24/showinfo.svg"
  '';
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        systemd.user.services.btrfs-desktop-notification = {
          Install = {
            WantedBy = [ config.wayland.systemd.target ];
          };

          Unit = {
            ConditionEnvironment = "WAYLAND_DISPLAY";
            Description = "btrfs-desktop-notification";
            After = [ config.wayland.systemd.target ];
            PartOf = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart = "${btrfs-desktop-notification}/bin/btrfs-desktop-notification";
            Restart = "always";
            RestartSec = "10";
          };
        };

      }
    )
  ];
}
