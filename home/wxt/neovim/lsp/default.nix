{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./c.nix
    #./latex.nix
    ./nix.nix
    ./python.nix
  ];
  programs.nixvim.plugins.lsp = {
    enable = true;
    keymaps.lspBuf = {
      K = "hover";
      gD = "references";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
    };
  };

  programs.nixvim.keymaps = [
    {
      key = "<M-CR>";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      options = {
        desc = "Code Actions";
      };
      mode = [ "n" ];
    }
  ];

  programs.nixvim.extraConfigLua = # lua
    ''
      --  LspInfo window borders
      local win = require "lspconfig.ui.windows"
      local _default_opts = win.default_opts

      win.default_opts = function(options)
        local opts = _default_opts(options)
        opts.border = "single"
        return opts
      end
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = {
          { "╭" },
          { "─" },
          { "╮" },
          { "│" },
          { "╯" },
          { "─" },
          { "╰" },
          { "│" },
        }
      })
    '';
}
