{
  pkgs,
  config,
  lib,
  ...
}:

{
  services.ejabberd = {
    enable = true;
    imagemagick = true;
    configFile = ./ejabberd.yml;
    ctlConfig = ./ejabberdctl.cfg;
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
}
