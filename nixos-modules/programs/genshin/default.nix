{
  an-anime-game-launcher,
  pkgs,
  config,
  lib,
  ...
}:

with pkgs;
{
  options = {
    EnableAnimeGameLauncher = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };
  imports = [
    an-anime-game-launcher.nixosModules.default
  ];
  config = lib.mkIf config.EnableAnimeGameLauncher {
    programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
    environment.systemPackages = [
      (buildFHSEnv {
        pname = "anime-game-launcher-wrapped";
        version =
          an-anime-game-launcher.packages.${pkgs.stdenv.hostPlatform.system}.an-anime-game-launcher.version;
        targetPkgs = pkgs: [
          an-anime-game-launcher.packages.${pkgs.stdenv.hostPlatform.system}.an-anime-game-launcher
          gamescope
        ];
        extraBwrapArgs = [
          "--hostname steamdeck"
          "--unshare-uts"
        ];
        runScript = "anime-game-launcher"; # a small script to choose what to exec
      })
    ];
  };
}
