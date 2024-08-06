{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  services.printing.drivers = [ pkgs.hplipWithPlugin ];
  services.printing.enable = true;
}
