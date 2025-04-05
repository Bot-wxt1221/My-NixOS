{
  lib,
  ...
}:
{
  imports = [

  ];
  services.swaync = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./swaync.json);
    style = ./swaync.css;
  };
  xdg.configFile."swaync/config.json".onChange = lib.mkForce "";
  xdg.configFile."swaync/style.css".onChange = lib.mkForce "";
}
