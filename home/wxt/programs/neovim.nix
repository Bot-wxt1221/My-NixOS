{
  config,
  pkgs,
  neovim,
  nvchad,
  luogu-gcc,
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
    #    neovim = neovim.packages.${pkgs.system}.default;
    #    gcc = luogu-gcc.packages.x86_64-linux.gcc-930;
    extraPackages = with pkgs; [ clang-tools ];
  };
  home.packages = with pkgs; [ clang-tools ];
  home.persistence."/persist/home/wxt" = {
    directories = [
      ".local/share/nvim"
      ".local/state/nvim"
    ];
  };
}
