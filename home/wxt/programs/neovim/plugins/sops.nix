{
  pkgs,
  lib,
  config,
}:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-sops
  ];
  extraConfigLuaPost = "require('nvim_sops').setup()";
}
