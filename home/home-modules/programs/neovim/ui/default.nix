{
  pkgs,
  ...
}:

{
  imports = [
    ./lualine.nix
  ];

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    plenary-nvim
  ];
  programs.nixvim = {
    extraConfigLua = ''
      local opt = vim.opt
      local o = vim.o
      local g = vim.g
      o.background = "light"
      o.laststatus = 3
      o.showmode = false

      o.clipboard = "unnamedplus"
      o.cursorline = true
      o.cursorlineopt = "number"

      -- Indenting
      o.expandtab = true
      o.shiftwidth = 2
      o.smartindent = true
      o.tabstop = 2
      o.softtabstop = 2

      opt.fillchars = { eob = " " }
      o.ignorecase = true
      o.smartcase = true
      o.mouse = "a"

      -- Numbers
      o.number = true
      o.numberwidth = 2
      o.ruler = false

      -- disable nvim intro
      opt.shortmess:append "sI"

      o.signcolumn = "yes"
      o.splitbelow = true
      o.splitright = true
      o.timeoutlen = 400
      o.undofile = true

      -- interval for writing swap file to disk, also used by gitsigns
      o.updatetime = 250

      -- go to previous/next line with h,l,left arrow and right arrow
      -- when cursor reaches end/beginning of line
      opt.whichwrap:append "<>[]hl"

      -- disable some default providers
      g.loaded_node_provider = 0
      g.loaded_python3_provider = 0
      g.loaded_perl_provider = 0
      g.loaded_ruby_provider = 0
    '';
    colorschemes.gruvbox.enable = true;
    colorschemes.gruvbox.settings = {
      terminal_colors = true; # add neovim terminal colors
      undercurl = true;
      underline = true;
      bold = true;
      italic = {
        strings = true;
        emphasis = true;
        comments = true;
        operators = false;
        folds = true;
      };
      strikethrough = true;
      invert_selection = false;
      invert_signs = false;
      invert_tabline = false;
      invert_intend_guides = false;
      inverse = true; # invert background for search, diffs, statuslines and errors
      contrast = ""; # can be "hard", "soft" or empty string
      palette_overrides = { };
      overrides = { };
      dim_inactive = false;
      transparent_mode = false;
    };
  };
  programs.nixvim.extraConfigVim = ''
    nnoremap <S-Up> <PageUp>
    nnoremap <S-Down> <PageDown>
  '';
  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>n";
      action = "<cmd>set nu!<CR>";
      options = {
        desc = "Toggle Line number";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>h";
      action = "<cmd>split term://$SHELL<CR>";
      options = {
        desc = "Open Shell";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>x";
      action = "<cmd>:bdelete<CR>";
      options = {
        desc = "Delete Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<Tab>";
      action = "<cmd>:bnext<CR>";
      options = {
        desc = "Next Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<S-Tab>";
      action = "<cmd>:bprevious<CR>";
      options = {
        desc = "Previous Buffer";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {
        desc = "Toggle Relative number";
      };
    }
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}
