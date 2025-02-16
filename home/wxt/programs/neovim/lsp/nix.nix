{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  programs.nixvim.plugins.lsp.servers.nixd = {
    enable = true;
  };
}
