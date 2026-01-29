{
  pkgs,
  lib,
  config,
  osConfig,
  dms,
  ...
}:
let
  jsonFormat = pkgs.formats.json { };
  generateJson =
    name: value:
    if lib.isString value then
      pkgs.writeText "dms-${name}.json" value
    else if builtins.isPath value || lib.isStorePath value then
      value
    else
      jsonFormat.generate "dms-${name}.json" value;
in
{
  imports = [
    dms.homeModules.default
  ];
  config = {
    programs.dank-material-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      enableSystemMonitoring = true;
      enableAudioWavelength = true;
      enableClipboardPaste = true;
    };
    home.file.".config/DankMaterialShell/settings.json" = {
      source = generateJson "settings" (import ./settings.nix { inherit lib config osConfig; });
    };
  };
}
