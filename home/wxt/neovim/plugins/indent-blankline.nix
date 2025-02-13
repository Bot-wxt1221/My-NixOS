{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "│";
        highlight = "IblChar";
      };
      scope = {
        char = "│";
        highlight = "IblScopeChar";
      };
      exclude = {
        buftypes = [
          "terminal"
          "quickfix"
        ];
        filetypes = [
          "checkhealth"
          "help"
          "lspinfo"
          "TelescopePrompt"
          "TelescopeResults"
        ];
      };
    };
  };

  programs.nixvim.highlight = {
    IblChar = {
      fg = colors.line;
    };
    IblScopeChar = {
      fg = colors.grey;
    };
    "@ibl.scope.underline.1" = {
      bg = colors.black2;
      underline = false;
      cterm = null;
    };
  };
  programs.nixvim.highlightOverride = {
    "@ibl.scope.underline.1" = {
      bg = colors.black2;
      underline = false;
      cterm = null;
    };
  };
}
