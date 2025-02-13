{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      highlights = {
        background = {
          fg = colors.light_grey;
          bg = colors.black2;
        };
        indicator_visible = {
          fg = colors.black2;
          bg = colors.black2;
        };
        buffer_selected = {
          fg = colors.white;
          bg = colors.black;
          italic = false;
          bold = false;
        };
        buffer_visible = {
          fg = colors.light_grey;
          bg = colors.black2;
        };
        offset_separator = {
          fg = colors.light_grey;
          bg = colors.black;
        };

        error = {
          fg = colors.light_grey;
          bg = colors.black2;
        };
        error_diagnostic = {
          fg = colors.light_grey;
          bg = colors.black2;
        };

        close_button = {
          fg = colors.light_grey;
          bg = colors.black2;
        };
        close_button_visible = {
          fg = colors.light_grey;
          bg = colors.black2;
        };
        close_button_selected = {
          fg = colors.red;
          bg = colors.black;
        };
        fill = {
          fg = colors.grey_fg;
          bg = colors.black2;
        };
        indicator_selected = {
          fg = colors.black;
          bg = colors.black;
        };

        modified = {
          fg = colors.red;
          bg = colors.black2;
        };
        modified_visible = {
          fg = colors.red;
          bg = colors.black2;
        };
        modified_selected = {
          fg = colors.green;
          bg = colors.black;
        };

        separator = {
          fg = colors.black2;
          bg = colors.black2;
        };
        separator_visible = {
          fg = colors.black2;
          bg = colors.black2;
        };
        separator_selected = {
          fg = colors.black2;
          bg = colors.black2;
        };

        tab = {
          fg = colors.light_grey;
          bg = colors.one_bg3;
        };
        tab_selected = {
          fg = colors.black2;
          bg = colors.nord_blue;
        };
        tab_close = {
          fg = colors.red;
          bg = colors.black;
        };

        duplicate = {
          fg = "NONE";
          bg = colors.black2;
        };
        duplicate_selected = {
          fg = colors.red;
          bg = colors.black;
        };
        duplicate_visible = {
          fg = colors.blue;
          bg = colors.black2;
        };
      };
      options = {
        always_show_bufferline = true;
        show_tab_indicators = false;
        offsets = [
          {
            filetype = "NvimTree";
            padding = 1;
            highlight = "NvimTreeWinSeparator";
          }
        ];
        indicator.style = null;
        indicator.icon = " ";
      };
    };
  };

  # Solves the issue of nvim-tree focusing after a buffer is deleted
  programs.nixvim.plugins.vim-bbye.enable = true;

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options = {
        desc = "Cycle to next buffer";
      };
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options = {
        desc = "Cycle to previous buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>enew<cr>";
      options = {
        desc = "Create new empty buffer";
      };
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>Bdelete<cr>";
      options = {
        desc = "Delete (close) current buffer";
      };
    }
  ];
}
