{
  pkgs,
  lib,
  config,
  ...
}:

{
  config = {
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
        ExecStart = "${lib.getExe pkgs.noctalia-shell}";
        Restart = "always";
        RestartSec = "10";
      };
    };
  };
}
