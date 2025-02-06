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
    acceleration = false;
    user = "ollama";
    group = "ollama";
  };
  systemd.services.ollama = {
    serviceConfig.BindReadOnlyPaths = [ "/proc/meminfo:${./meminfo.txt}" ];
    serviceConfig.ProcSubset = lib.mkForce false;
  };
}
