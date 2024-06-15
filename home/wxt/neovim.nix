{ config, pkgs, neovim, ... }:
{
  imports = [

  ];
  programs.neovim={
    enable = true;
    package = neovim.packages.${pkgs.system}.default;
    plugins = [
	{ plugin = pkgs.vimPlugins.nvchad; }
    ];
  };
}
