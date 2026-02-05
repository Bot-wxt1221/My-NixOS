{
  pkgs,
  lib,
  config,
  osConfig,
  dms,
  dms-plugin-registry,
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
      plugins = {
        dankKDEConnect = {
          enable = true;
          settings = {
            enable = true;
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.dankKDEConnect;
        };
        niriWindows = {
          enable = true;
          settings = {
            enable = true;
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.niriWindows;
        };
        powerOptions = {
          enable = true;
          settings = {
            enable = true;
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.powerOptions;
        };
        calculator = {
          enable = true;
          settings = {
            enable = true;
            trigger = "=";
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.calculator;
        };
        powerUsagePlugin = {
          enable = true;
          settings = {
            enable = true;
            selectedPopout = "battery";
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.powerUsagePlugin;
        };
        emojiLauncher = {
          enable = true;
          settings = {
            enable = true;
            trigger = "@";
          };
          src = dms-plugin-registry.packages.${pkgs.stdenv.hostPlatform.system}.emojiLauncher;
        };

      };
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
    home.activation.copy-session = ''
      cp ${./session.json} /home/wxt/.local/state/DankMaterialShell/session.json
    '';
  };
}
