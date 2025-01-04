{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  services.printing.drivers = [
    pkgs.hplipWithPlugin
  ];
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/cups"
    ];
  };
  services.printing.enable = true;
}
