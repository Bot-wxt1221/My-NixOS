{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.EnableEjabberd = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.EnableEjabberd {
    services.ejabberd = {
      enable = true;
      imagemagick = true;
      configFile = ./ejabberd.yml;
      ctlConfig = builtins.readFile ./ejabberdctl.cfg;
    };
    environment.persistence."/persist" = {
      directories = [
        {
          directory = "/var/lib/private/ejabberd";
          user = config.services.ejabberd.user;
          group = config.services.ejabberd.group;
          mode = "0700";
        }
      ];
    };
  };
}
