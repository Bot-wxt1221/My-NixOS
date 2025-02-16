{
  programs.nixvim.plugins.comment = {
    enable = true;
    settings.mappings = false;
    settings.toggler.line = "<A-/>";
    settings.toggler.block = "<S-A-/>";
  };

  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "i"
      ];
      key = "<A-/>";
      action = "<cmd>lua require('Comment.api').locked('toggle.linewise.current')()<CR>";
      options = {
        desc = "toggle single line comment";
      };
    }
    {
      mode = [ "v" ];
      key = "<A-/>";
      action = "<ESC><cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>";
      options = {
        desc = "toggle selected lines comment";
      };
    }

  ];
}
