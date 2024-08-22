{
  config,
  pkgs,
  neovim,
  nvchad,
  ...
}:
{
  imports = [ nvchad.homeManagerModule ];
  #  programs.neovim = {
  #    enable = true;
  #    package = neovim.packages.${pkgs.system}.default;
  #  };
  programs.nvchad = {
    enable = true;
    neovim = neovim.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [ clang-tools ];
  };
  home.packages = with pkgs; [ clang-tools ];
}
