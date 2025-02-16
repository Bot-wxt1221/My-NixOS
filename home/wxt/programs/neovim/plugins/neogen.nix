{
  programs.nixvim.plugins.neogen = {
    enable = true;
    languages = {
      python = {
        template = {
          annotation_convention = "reST";
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>ds";
      action = "<cmd>lua require('neogen').generate({ type = 'func' })<cr>";
      options = {
        desc = "generate docstring for a function";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>dc";
      action = "<cmd>lua require('neogen').generate({ type = 'class' })<cr>";
      options = {
        desc = "generate docstring for a class";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>df";
      action = "<cmd>lua require('neogen').generate({ type = 'file' })<cr>";
      options = {
        desc = "generate docstring for a file";
      };
    }
  ];
}
