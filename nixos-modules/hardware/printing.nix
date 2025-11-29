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
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="03f0", ATTR{idProduct}=="002a", ATTR{power/control}="on"
  '';
  services.printing.enable = true;
  systemd.services.cups.enable = true;
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      userServices = true;
    };
  };
  services.printing.browsing = true;
  services.printing.defaultShared = true;
  services.printing.extraConf = ''
    ServerName 0.0.0.0
  '';
  services.printing.listenAddresses = [
    "*:631"
  ];
  services.printing.allowFrom = [
    "all"
  ];
}
