{
  config,
  pkgs,
  neovim,
  nvchad,
  starter,
  ...
}:
{
  imports = [
    nvchad.homeManagerModule
  ];
#  programs.neovim = {
#    enable = true;
#    package = neovim.packages.${pkgs.system}.default;
#  };
  programs.nvchad = {
    enable = true;
    neovim = neovim.packages.${pkgs.system}.default;
    extraConfig = ${starter};
  };
}
