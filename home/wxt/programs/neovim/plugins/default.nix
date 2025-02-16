{
  imports = [
    ./auto-save.nix
    ./autopairs.nix
    ./comment.nix
    ./git.nix
    ./guess-indent.nix
    ./indent-blankline.nix
    ./neogen.nix
    ./visual-multi.nix
    ./which-key.nix
    ./competitest.nix
    ./editorconfig.nix
    ./nvim-tree.nix
    ./telescope.nix
  ];

  # proper <C-S-...> selections from insert and normal modes
  programs.nixvim.opts.keymodel = "startsel";

  programs.nixvim.keymaps = [
    # misc
    {
      mode = [
        "n"
        "i"
        "v"
      ];
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        desc = "Save File";
      };
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<S-A-q>";
      action = "<cmd>wqa<cr>";
      options = {
        desc = "Save and close all";
      };
    }
    {
      mode = [ "n" ];
      key = "<A-S-t>";
      action = "<cmd>tabclose<CR>";
      options = {
        desc = "close current tab";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>gd";
      action = "<cmd>normal! gd<cr>";
      options = {
        desc = "use nvim's built-in goto definition";
      };
    }
    {
      mode = [ "n" ];
      key = "<Esc>";
      action = "<cmd>noh<cr>";
      options = {
        desc = "Clear highlights";
      };
    }
    {
      mode = [ "i" ];
      key = "<C-BS>";
      action = "<C-w>";
      options = {
        desc = "Delete word backwards";
      };
    }

    # custom motions
    {
      mode = [ "n" ];
      key = "<A-Right>";
      action = "$";
      options = {
        desc = "goto end of line";
      };
    }
    {
      mode = [ "n" ];
      key = "<A-Left>";
      action = "^";
      options = {
        desc = "goto start of line";
      };
    }
    {
      mode = [ "i" ];
      key = "<A-Right>";
      action = "<cmd>ASToggle<cr><ESC>A<cmd>ASToggle<cr>";
      options = {
        desc = "goto end of line";
      };
    }
    {
      mode = [ "i" ];
      key = "<A-Left>";
      action = "<cmd>ASToggle<cr><ESC>I<cmd>ASToggle<cr>";
      options = {
        desc = "goto start of line";
      };
    }

    # quick edits
    {
      mode = [ "i" ];
      key = "<C-Down>";
      action = "<cmd> :move +1<CR>";
      options = {
        desc = "move current line one down";
      };
    }
    {
      mode = [ "i" ];
      key = "<C-Up>";
      action = "<cmd> :move -2<CR>";
      options = {
        desc = "move current line one up";
      };
    }
    {
      mode = [ "n" ];
      key = "<A-u>";
      action = "guiw";
      options = {
        desc = "transform word under cursor to lowercase";
      };
    }
    {
      mode = [ "n" ];
      key = "<A-U>";
      action = "gUiw";
      options = {
        desc = "transform word under cursor to uppercase";
      };
    }

    # window movements & sizing
    {
      mode = [ "n" ];
      key = "<C-S-Left>";
      action = "<C-w>h";
      options = {
        desc = " window left";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-Right>";
      action = "<C-w>l";
      options = {
        desc = " window right";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-Down>";
      action = "<C-w>j";
      options = {
        desc = " window down";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-Up>";
      action = "<C-w>k";
      options = {
        desc = " window up";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-A-Right>";
      action = "<cmd>vsp<CR>";
      options = {
        desc = "open new window to the right";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-A-Down>";
      action = "<cmd>sp<CR>";
      options = {
        desc = "open new window to the bottom";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-A-Left>";
      action = "20<C-w><";
      options = {
        desc = "decrease window width";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-A-Right>";
      action = "20<C-w>>";
      options = {
        desc = "increase window width";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-A-Up>";
      action = "15<C-w>+";
      options = {
        desc = "increase window height";
      };
    }
    {
      mode = [ "n" ];
      key = "<C-S-A-Down>";
      action = "15<C-w>-";
      options = {
        desc = "decrease window width";
      };
    }
  ];
}
