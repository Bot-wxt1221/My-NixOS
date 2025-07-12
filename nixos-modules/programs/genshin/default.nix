{
  an-anime-game-launcher,
  pkgs,
  ...
}:

with pkgs;
{
  imports = [
    an-anime-game-launcher.nixosModules.default
  ];
  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
  environment.systemPackages = [
    (buildFHSEnv {
      pname = "anime-game-launcher-wrapped";
      version = an-anime-game-launcher.packages.${pkgs.system}.an-anime-game-launcher.version;
      targetPkgs = pkgs: [
        an-anime-game-launcher.packages.${pkgs.system}.an-anime-game-launcher
        gamescope
      ];
      extraBwrapArgs = [
        "--hostname steamdeck"
        "--unshare-uts"
      ];
      runScript = "anime-game-launcher"; # a small script to choose what to exec
    })
  ];
}
