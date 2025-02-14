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
      -- shamelessly copied from: https://github.com/NvChad/ui/blob/v2.5/lua/nvchad/lsp/init.lua
      local function lspSymbol(name, icon)
        local hl = "DiagnosticSign" .. name
        vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
      end

      lspSymbol("Error", "󰅙")
      lspSymbol("Info", "󰋼")
      lspSymbol("Hint", "󰌵")
      lspSymbol("Warn", "")

      vim.diagnostic.config {
        virtual_text = {
          prefix = "",
        },
        signs = true,
        underline = true,

        float = {
          border = "single",
        },
      }

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
