{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins = {
    fugitive.enable = true;
    gitsigns = {
      enable = true;
      settings.signs = {
        add = {
          text = "│";
        };
        change = {
          text = "│";
        };
        delete = {
          text = "󰍵";
        };
        topdelete = {
          text = "‾";
        };
        changedelete = {
          text = "~";
        };
        untracked = {
          text = "│";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>gb";
      action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
      options = {
        desc = "toggle current line blame";
      };
    }
  ];

  programs.nixvim.highlight = {
    diffOldFile = {
      fg = colors.baby_pink;
    };
    diffNewFile = {
      fg = colors.blue;
    };
    DiffAdd = {
      fg = colors.blue;
    };
    DiffAdded = {
      fg = colors.green;
    };
    DiffChange = {
      fg = colors.light_grey;
    };
    DiffChangeDelete = {
      fg = colors.red;
    };
    DiffModified = {
      fg = colors.orange;
    };
    DiffDelete = {
      fg = colors.red;
    };
    DiffRemoved = {
      fg = colors.red;
    };
    DiffText = {
      fg = colors.white;
      bg = colors.black2;
    };
    gitcommitOverflow = {
      fg = colors.base08;
    };
    gitcommitSummary = {
      fg = colors.base0B;
    };
    gitcommitComment = {
      fg = colors.base03;
    };
    gitcommitUntracked = {
      fg = colors.base03;
    };
    gitcommitDiscarded = {
      fg = colors.base03;
    };
    gitcommitSelected = {
      fg = colors.base03;
    };
    gitcommitHeader = {
      fg = colors.base0E;
    };
    gitcommitSelectedType = {
      fg = colors.base0D;
    };
    gitcommitUnmergedType = {
      fg = colors.base0D;
    };
    gitcommitDiscardedType = {
      fg = colors.base0D;
    };
    gitcommitBranch = {
      fg = colors.base09;
      bold = true;
    };
    gitcommitUntrackedFile = {
      fg = colors.base0A;
    };
    gitcommitUnmergedFile = {
      fg = colors.base08;
      bold = true;
    };
    gitcommitDiscardedFile = {
      fg = colors.base08;
      bold = true;
    };
    gitcommitSelectedFile = {
      fg = colors.base0B;
      bold = true;
    };
  };

}
