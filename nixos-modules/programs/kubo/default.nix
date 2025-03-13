{
  config,
  lib,
  ...
}:
{
  imports = [ ];
  options = {
    EnableKubo = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  config = lib.mkIf config.EnableKubo {
    services.kubo = {
      enable = true;
      user = "wxt";
      enableGC = true;
      autoMount = true;
      settings.Addresses.API = [ "/ip4/127.0.0.1/tcp/5001" ];
      settings.Datastore.StorageMax = "100GB";
    };
  };
}
