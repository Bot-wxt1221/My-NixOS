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
    extraPlugins = ''
    return {
      "nvim-lualine/lualine.nvim"
    }
    '';
  };
  home.packages = with pkgs; [ clang-tools ];
}
