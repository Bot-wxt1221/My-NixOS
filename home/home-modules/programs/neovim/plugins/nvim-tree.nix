_:
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
        key = "<leader>e";
        action = "<cmd>NvimTreeFocus<CR>";
        options = {
          desc = "Nvimtree Toggle window";
        };
        mode = [ "n" ];
      }
    ];
  };
}
