{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    nvim-sops
  ];
  programs.nixvim.extraConfigLuaPost = "require('nvim_sops').setup()";
}
