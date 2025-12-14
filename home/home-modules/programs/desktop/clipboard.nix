{
  pkgs,
  config,
  lib,
  clipboard,
  ...
}:
{
  imports = [

  ];
  config = lib.mkIf config.enableDesktop {
    home.packages = with pkgs; [ wl-clip-persist ];
    systemd.user.services.wl-clip-persist = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "wl-clip-persist";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${lib.getExe pkgs.wl-clip-persist} --clipboard regular";
        Restart = "always";
        RestartSec = "10";
      };
    };
    systemd.user.services.clipboard-sync = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "clipboard-sync";
        After = [ config.wayland.systemd.target ];
        PartOf = [ config.wayland.systemd.target ];
      };

      Service = {
        ExecStart = "${clipboard.packages."x86_64-linux".default}/bin/clipboard-sync --hide-timestamp";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
