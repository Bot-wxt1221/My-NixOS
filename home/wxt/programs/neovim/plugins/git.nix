{ ... }:
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
}
