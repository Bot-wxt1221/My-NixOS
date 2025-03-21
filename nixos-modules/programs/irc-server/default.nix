{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.EnableIRC = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.EnableIRC {
    services.ngircd = {
      enable = true;
      config = builtins.readFile ./irc-config;
    };
  };
}
