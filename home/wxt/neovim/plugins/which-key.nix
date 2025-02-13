{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins.which-key = {
    enable = true;
  };

  programs.nixvim.highlight = {
    WhichKey = {
      fg = colors.blue;
    };
    WhichKeySeparator = {
      fg = colors.light_grey;
    };
    WhichKeyDesc = {
      fg = colors.red;
    };
    WhichKeyGroup = {
      fg = colors.green;
    };
    WhichKeyValue = {
      fg = colors.green;
    };
  };
}
