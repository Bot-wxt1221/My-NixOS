{ config, pkgs, neovim, ... }:
{
  imports = [

  ];
  neovim.packages."${pkgs.system}".neovim
}
