{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = {
    programs = {
      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      bash.enable = true;
      zsh.enable = true;
    };
  };
}
