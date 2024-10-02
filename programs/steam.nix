{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    enableSteam = lib.mkEnableOption "Steam";
  };
  config = lib.mkIf config.enableSteam {
    programs.steam = {
      enable = true;
    };
  };
}
