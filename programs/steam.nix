{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    Enablesteam = lib.mkEnableOption "Steam";
  };
  config = lib.mkIf config.Enablesteam {
    programs.steam = {
      enable = true;
    };
  };
}
