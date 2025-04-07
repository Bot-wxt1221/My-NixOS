{
  lib,
  config,
  osConfig,
  ...
}:
{
  imports = [

  ];
  services.swaync = {
    enable = true;
    settings = import ./swaync-json.nix {
      inherit config lib osConfig;
    };
    style = ./swaync.css;
  };
  xdg.configFile."swaync/config.json".onChange = lib.mkForce "";
  xdg.configFile."swaync/style.css".onChange = lib.mkForce "";
}
