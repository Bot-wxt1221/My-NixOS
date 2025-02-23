{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/private/ollama";
      user = "ollama";
      group = "ollama";
      mode = "0700";
    }
  ];
  services.ollama = {
    enable = true;
    user = "ollama";
    group = "ollama";
  };
}
