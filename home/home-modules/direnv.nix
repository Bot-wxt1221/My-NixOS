{
  config,
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
    home.persistence."/persist/home/wxt" = {
      directories = [
        ".config/direnv"
        ".local/share/direnv"
      ];
    };
  };
}
