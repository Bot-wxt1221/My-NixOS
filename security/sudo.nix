{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  security.sudo.wheelNeedsPassword = true;
  systemd.services.idontwanttoreadstupidsudolecture = {
    enable = true;
    description = "I don't want to read stupid sudo lecture";
    serviceConfig.Type = "oneshot";
    script = ''
      touch /var/db/sudo/lectured/1000
    '';
  };
}
