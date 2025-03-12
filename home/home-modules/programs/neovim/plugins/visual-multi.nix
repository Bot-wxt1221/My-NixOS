{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [ { plugin = vim-visual-multi; } ];
  programs.nixvim.globals = {
    VM_maps = {
      "Find Under" = "<C-d>";
      "Find Subword Under" = "<C-d>";
    };
    VM_quit_after_leaving_insert_mode = 1;
    VM_skip_empty_lines = 1;
  };
  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<A-Up>";
      action = "<cmd>call vm#commands#add_cursor_up(0, v:count1)<CR>";
      options = {
        desc = "add a cursor below";
        noremap = true;
        silent = true;
      };
    }
    {
      mode = [ "n" ];
      key = "<A-Down>";
      action = "<cmd>call vm#commands#add_cursor_down(0, v:count1)<CR>";
      options = {
        desc = "add a cursor below";
        noremap = true;
        silent = true;
      };
    }
  ];
}
