{
  an-anime-game-launcher,
  pkgs,
  ...
}:

{
  imports = [
    an-anime-game-launcher.nixosModules.default
  ];
  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
}
