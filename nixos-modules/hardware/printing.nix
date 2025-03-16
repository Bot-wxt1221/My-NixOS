{
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
  preservation.preserveAt."/persist" = {
    directories = [
      "/var/lib/cups"
    ];
  };
  services.printing.enable = true;
}
