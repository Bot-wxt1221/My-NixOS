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
    vim.diagnostic.config {
      virtual_text = { prefix = "" },
      signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
      underline = true,
      float = { border = "single" },
    }

    -- Default border style
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = "rounded"
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
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
