{
  pkgs,
  config,
  osConfig,
  noctalia,
  ...
}:

{
  imports = [ noctalia.homeModules.default ];
  config = {
    programs.noctalia-shell = {
      enable = true;
      package = pkgs.noctalia-shell;
      colors = ./colors.json;
      plugins = ./plugins.json;
      settings = import ./settings.nix { inherit config osConfig; };
    };
  };
}
