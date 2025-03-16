{
  config,
  lib,
  ...
}:
{
  imports = [

  ];
  options.EnableOllama = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.EnableOllama {
    preservation.preserveAt."/persist" = {
      directories = [
        {
          directory = "/var/lib/private/ollama";
          user = "ollama";
          group = "ollama";
          mode = "0700";
        }
      ];
    };
    services.ollama = {
      enable = true;
      user = "ollama";
      group = "ollama";
    };
  };
}
