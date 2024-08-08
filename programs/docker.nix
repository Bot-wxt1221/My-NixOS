{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];
  options = {
    EnableDocker = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

  };
  config = lib.mkIf config.EnableDocker {
    virtualisation.docker.enable = true;
    environment.systemPackages = with pkgs; [ docker ];
  };
}
