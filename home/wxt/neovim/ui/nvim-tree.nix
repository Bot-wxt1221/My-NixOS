{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim = {
    plugins.nvim-tree = {
      enable = true;
      filters = {
        dotfiles = false;
      };
      disableNetrw = true;
      hijackNetrw = true;
      hijackCursor = true;
      hijackUnnamedBufferWhenOpening = false;
      syncRootWithCwd = true;
      updateFocusedFile = {
        enable = true;
        updateRoot = false;
      };
      view = {
        side = "left";
        width = 35;
        preserveWindowProportions = true;
      };
      git = {
        enable = true;
        ignore = true;
      };
      filesystemWatchers = {
        enable = true;
      };
      actions = {
        openFile = {
          resizeWindow = false;
        };
      };
      renderer = {
        rootFolderLabel = false;
        highlightGit = true;
        highlightOpenedFiles = "none";
        indentMarkers = {
          enable = true;
        };
        icons = {
          show = {
            file = true;
            folder = true;
            folderArrow = true;
            git = true;
          };
          glyphs = {
            default = "󰈚";
            symlink = "";
            folder = {
              default = "";
              empty = "";
              emptyOpen = "";
              open = "";
              symlink = "";
              symlinkOpen = "";
              arrowOpen = "";
              arrowClosed = "";
            };
            git = {
              unstaged = "✗";
              staged = "✓";
              unmerged = "";
              renamed = "➜";
              untracked = "★";
              deleted = "";
              ignored = "◌";
            };
          };
        };
      };
    };

    keymaps = [
      {
        key = "<A-l>";
        action = "<cmd>NvimTreeToggle<CR>";
        options = {
          desc = "Nvimtree Toggle window";
        };
        mode = [ "n" ];
      }
    ];

    highlight = {
      NvimTreeEmptyFolderName = {
        fg = colors.folder_bg;
      };
      NvimTreeEndOfBuffer = {
        fg = colors.darker_black;
      };
      NvimTreeFolderIcon = {
        fg = colors.folder_bg;
      };
      NvimTreeFolderName = {
        fg = colors.folder_bg;
      };
      NvimTreeFolderArrowOpen = {
        fg = colors.folder_bg;
      };
      NvimTreeFolderArrowClosed = {
        fg = colors.grey_fg;
      };
      NvimTreeGitDirty = {
        fg = colors.red;
      };
      NvimTreeIndentMarker = {
        fg = colors.line;
      };
      NvimTreeNormal = {
        bg = colors.darker_black;
      };
      NvimTreeNormalNC = {
        bg = colors.darker_black;
      };
      NvimTreeOpenedFolderName = {
        fg = colors.folder_bg;
      };
      NvimTreeGitIgnored = {
        fg = colors.light_grey;
      };
      NvimTreeWinSeparator = {
        fg = colors.darker_black;
        bg = colors.darker_black;
      };
      NvimTreeWindowPicker = {
        fg = colors.red;
        bg = colors.black2;
      };
      NvimTreeCursorLine = {
        bg = colors.black2;
      };
      NvimTreeGitNew = {
        fg = colors.yellow;
      };
      NvimTreeGitDeleted = {
        fg = colors.red;
      };
      NvimTreeSpecialFile = {
        fg = colors.yellow;
        bold = true;
      };
      NvimTreeRootFolder = {
        fg = colors.red;
        bold = true;
      };
    };
  };
}
