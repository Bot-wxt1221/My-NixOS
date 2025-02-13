{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  programs.nixvim.plugins.telescope = {
    enable = true;

    settings.defaults = {
      vimgrep_arguments = [
        "rg"
        "-L"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
      ];
      prompt_prefix = "   ";
      selection_caret = "  ";
      entry_prefix = "  ";
      initial_mode = "insert";
      selection_strategy = "reset";
      sorting_strategy = "ascending";
      layout_strategy = "horizontal";
      layout_config = {
        horizontal = {
          prompt_position = "top";
          preview_width = 0.55;
          results_width = 0.8;
        };
        vertical = {
          mirror = false;
        };
        width = 0.87;
        height = 0.80;
        preview_cutoff = 120;
      };
      file_sorter = {
        __raw = # lua
          ''require("telescope.sorters").get_fuzzy_file '';
      };
      file_ignore_patterns = [ "node_modules" ];
      generic_sorter = {
        __raw = # lua
          ''require("telescope.sorters").get_generic_fuzzy_sorter '';
      };
      path_display = [ "truncate" ];
      winblend = 0;
      border = { };
      borderchars = [
        "─"
        "│"
        "─"
        "│"
        "╭"
        "╮"
        "╯"
        "╰"
      ];
      color_devicons = true;
      set_env = {
        COLORTERM = "truecolor";
      };
      file_previewer = {
        __raw = # lua
          ''require("telescope.previewers").vim_buffer_cat.new '';
      };
      grep_previewer = {
        __raw = # lua
          ''require ("telescope.previewers").vim_buffer_vimgrep.new '';
      };
      qflist_previewer = {
        __raw = # lua
          ''require ("telescope.previewers").vim_buffer_qflist.new '';
      };
      buffer_previewer_maker = {
        __raw = # lua
          ''require("telescope.previewers").buffer_previewer_maker '';
      };
      mappings = {
        i = {
          "<esc>" = {
            __raw = # lua
              ''
                function(...)
                  return require("telescope.actions").close(...)
                end
              '';
          };
        };
      };
    };

    extensions.fzf-native = {
      enable = true;
      settings = {
        fuzzy = true;
        override_generic_sorter = true;
        override_file_sorter = true;
        case_mode = "smart_case";
      };
    };
    extensions.ui-select.enable = true;
  };

  programs.nixvim.keymaps = [
    {
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep<CR>";
      options = {
        desc = "Telescope Live grep";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options = {
        desc = "Telescope Find buffers";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options = {
        desc = "Telescope Help page";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>fz";
      action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
      options = {
        desc = "Telescope Find in current buffer";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>cm";
      action = "<cmd>Telescope git_commits<CR>";
      options = {
        desc = "Telescope Git commits";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>gt";
      action = "<cmd>Telescope git_status<CR>";
      options = {
        desc = "Telescope Git status";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
      options = {
        desc = "Telescope Find files";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>fa";
      action = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>";
      options = {
        desc = "Telescope Find all files";
      };
      mode = [ "n" ];
    }
    {
      key = "<leader>tr";
      action = "<cmd>Telescope resume<CR>";
      options = {
        desc = "re--open last telescope buffer";
      };
      mode = [ "n" ];
    }
  ];

  programs.nixvim.highlight = {
    TelescopePromptPrefix = {
      fg = colors.red;
      bg = colors.black2;
    };
    TelescopeNormal = {
      bg = colors.darker_black;
    };
    TelescopePreviewTitle = {
      fg = colors.black;
      bg = colors.green;
    };
    TelescopePromptTitle = {
      fg = colors.black;
      bg = colors.red;
    };
    TelescopeSelection = {
      bg = colors.black2;
      fg = colors.white;
    };
    TelescopeResultsDiffAdd = {
      fg = colors.green;
    };
    TelescopeResultsDiffChange = {
      fg = colors.yellow;
    };
    TelescopeResultsDiffDelete = {
      fg = colors.red;
    };
    TelescopeMatching = {
      bg = colors.one_bg;
      fg = colors.blue;
    };
    TelescopeBorder = {
      fg = colors.darker_black;
      bg = colors.darker_black;
    };
    TelescopePromptBorder = {
      fg = colors.black2;
      bg = colors.black2;
    };
    TelescopePromptNormal = {
      fg = colors.white;
      bg = colors.black2;
    };
    TelescopeResultsTitle = {
      fg = colors.darker_black;
      bg = colors.darker_black;
    };
  };
}
