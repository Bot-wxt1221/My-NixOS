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
    (pkgs.hplipWithPlugin.overrideAttrs (old: {
      env = {
        NIX_CFLAGS_COMPILE = toString [
          "-Wno-error=implicit-int"
          "-Wno-error=implicit-function-declaration"
          "-Wno-error=return-mismatch"
          "-Wno-error=int-conversion"
          "-Wno-error=incompatible-pointer-types"
        ];
      };
    }))
  ];
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/cups"
    ];
  };
  services.printing.enable = true;
}
