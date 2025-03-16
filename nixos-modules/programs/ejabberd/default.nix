{
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
    preservation.preserveAt."/persist" = {
      directories = [
        {
          directory = "/var/lib/private/ejabberd";
          inherit (config.services.ejabberd) user;
          inherit (config.services.ejabberd) group;
          mode = "0700";
        }
      ];
    };
  };
}
