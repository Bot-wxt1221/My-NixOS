{
  config,
  lib,
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
