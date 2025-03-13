{
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
        virtual_text = {
          prefix = "",
        },
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅙",
          [vim.diagnostic.severity.INFO] = "󰋼",
          [vim.diagnostic.severity.HINT] = "󰌵",
          [vim.diagnostic.severity.WARN] = "",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticSign" .. "Error",
          [vim.diagnostic.severity.INFO] = "DiagnosticSign" .. "Info",
          [vim.diagnostic.severity.HINT] = "DiagnosticSign" .. "Hint",
          [vim.diagnostic.severity.WARN] = "DiagnosticSign" .. "Warn",
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
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    autoLoad = true;
    settings.sources = [
      { name = "nvim_lsp"; }
      { name = "luasnip"; }
      { name = "buffer"; }
      { name = "nvim_lua"; }
      { name = "path"; }
    ];
    settings.mapping = {
      "<C-p>" = "cmp.mapping.select_prev_item()";
      "<C-n>" = "cmp.mapping.select_next_item()";
      "<C-d>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-e>" = "cmp.mapping.close()";
      "<CR>" = ''
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }
      '';
      "<Tab>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" })
      '';
      "<S-Tab>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" })
      '';
    };
  };

}
