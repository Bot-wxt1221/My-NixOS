{
  lib,
  osConfig,
  ...
}:
{
  imports = [

  ];
  services.swaync = {
    enable = true;
    settings = import ./swaync-json.nix {
      inherit lib osConfig;
    };
    style = ./swaync.css;
  };
  systemd.user.services.swaync = {
    Unit = {
      X-Restart-Triggers = lib.mkForce [ ];
    };
  };
  xdg.configFile."swaync/config.json".onChange = lib.mkForce "";
  xdg.configFile."swaync/style.css".onChange = lib.mkForce "";
}
