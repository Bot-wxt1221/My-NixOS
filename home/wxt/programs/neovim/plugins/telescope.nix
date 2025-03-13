_:
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
  programs.nixvim.extraConfigLua = ''
    local map = vim.keymap.set

    map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
    map("i", "<C-e>", "<End>", { desc = "move end of line" })
    map("i", "<C-h>", "<Left>", { desc = "move left" })
    map("i", "<C-l>", "<Right>", { desc = "move right" })
    map("i", "<C-j>", "<Down>", { desc = "move down" })
    map("i", "<C-k>", "<Up>", { desc = "move up" })

    map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
    map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
    map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
    map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

    map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

    map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
    map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

    map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
    map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
    map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

    map("n", "<leader>fm", function()
      require("conform").format { lsp_fallback = true }
    end, { desc = "general format file" })
  '';

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
  ];
}
