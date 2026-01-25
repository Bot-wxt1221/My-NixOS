{
  lib,
  pkgs,
  config,
  osConfig,
  noctalia,
  ...
}:

{
  imports = [ noctalia.homeModules.default ];
  config = {
    programs.noctalia-shell = {
      enable = true;
      package = pkgs.noctalia-shell;
      colors = ./colors.json;
      plugins = ./plugins.json;
      settings = import ./settings.nix { inherit config osConfig; };
    };
    systemd.user.services.noctalia-shell = {
      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Unit = {
        ConditionEnvironment = "WAYLAND_DISPLAY";
        Description = "noctalia-shell";
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
