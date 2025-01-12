{
  config,
  pkgs,
  neovim,
  niri,
  nvchad,
  ...
}:

{
  imports = [
    ./gpg.nix
    ./direnv.nix
    ./desktop
    ./programs
    ./debug-cc.nix
    ./persist.nix
    ./virt.nix
    ./waydroid.nix
    ./java.nix
    ./utils.nix
    ./nix.nix
    ./zsh.nix
    ./git.nix
  ];
  nixpkgs.config.allowUnfree = true;
  home.username = "wxt";
  home.homeDirectory = "/home/wxt";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  programs.git.extraConfig = {
    commit = {
      gpgsign = true;
    };
    user = {
      signingKey = "EF9846DDF6C89DBC294F7741F62181757D8BF693";
    };
  };
}
