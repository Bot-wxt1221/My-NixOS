{ config, lib,pkgs, ... }:

{
  imports = [
    ./bufferline.nix
    ./colorizer.nix
    ./lualine.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./term.nix
  ];

  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    base46
  ];
  programs.nixvim.extraConfigLua = ''
    require("base46").load_all_highlights()
    vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

    for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
      dofile(vim.g.base46_cache .. v)
    end
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
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {
        desc = "Toggle Relative number";
      };
    }
  ];

  programs.nixvim.plugins.web-devicons.enable = true;
}
