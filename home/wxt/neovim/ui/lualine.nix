{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings.sections = {
      lualine_a = [ "mode" ];
      lualine_b = [ "filename" ];
      lualine_c = [ "branch" ];
      lualine_x = [ "diagnostics" ];
      lualine_y = [
        "searchcount"
        "location"
      ];
      lualine_z = [ "progress" ];
    };

    settings.options = {
      globalstatus = true;
      component_separators.left = "";
      component_separators.right = "";
      section_separators.left = "";
      section_separators.right = "";

      theme = lib.mkForce {
        normal.a = {
          fg = colors.base01;
          bg = colors.base0B;
        };
        normal.b = {
          fg = colors.base05;
          bg = colors.grey;
        };
        normal.c = {
          fg = colors.base04;
          bg = colors.line;
        };

        insert.a = {
          fg = colors.base01;
          bg = colors.base0A;
        };
        insert.b = {
          fg = colors.base05;
          bg = colors.grey;
        };
        insert.c = {
          fg = colors.base04;
          bg = colors.line;
        };

        visual.a = {
          fg = colors.base01;
          bg = colors.base09;
        };
        visual.b = {
          fg = colors.base05;
          bg = colors.grey;
        };
        visual.c = {
          fg = colors.base04;
          bg = colors.line;
        };

        terminal.a = {
          fg = colors.base01;
          bg = colors.base08;
        };
        terminal.b = {
          fg = colors.base05;
          bg = colors.grey;
        };
        terminal.c = {
          fg = colors.base04;
          bg = colors.line;
        };

        command.a = {
          fg = colors.base01;
          bg = colors.base0D;
        };
        command.b = {
          fg = colors.base05;
          bg = colors.grey;
        };
        command.c = {
          fg = colors.base04;
          bg = colors.line;
        };

        inactive.a = {
          fg = colors.base03;
          bg = colors.base01;
        };
        inactive.b = {
          fg = colors.base03;
          bg = colors.base01;
        };
        inactive.c = {
          fg = colors.base03;
          bg = colors.base01;
        };
      };
    };
  };

  programs.nixvim.opts = {
    # would be nice...
    # cmdheight = 0;
    laststatus = 3;
    shortmess = {
      C = true;
      F = true;
      A = true;
      W = true;
      I = true;
      S = true;
    };
  };
}
