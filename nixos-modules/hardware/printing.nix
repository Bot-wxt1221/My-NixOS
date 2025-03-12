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
    pkgs.cups-pdf-to-pdf
  ];
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/cups"
    ];
  };
  services.printing.enable = true;
}
