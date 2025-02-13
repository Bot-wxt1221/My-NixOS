{
  config,
  lib,
  pkgs,
  ...
}:
let
  colors = import ../colors.nix { inherit config lib; };
in
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

  programs.nixvim.highlight = {
    LspReferenceText = {
      fg = colors.darker_black;
      bg = colors.white;
    };
    LspReferenceRead = {
      fg = colors.darker_black;
      bg = colors.white;
    };
    LspReferenceWrite = {
      fg = colors.darker_black;
      bg = colors.white;
    };
    DiagnosticHint = {
      fg = colors.purple;
    };
    DiagnosticError = {
      fg = colors.red;
    };
    DiagnosticWarn = {
      fg = colors.yellow;
    };
    DiagnosticInformation = {
      fg = colors.green;
    };
    LspSignatureActiveParameter = {
      fg = colors.black;
      bg = colors.green;
    };
    RenamerTitle = {
      fg = colors.black;
      bg = colors.red;
    };
    RenamerBorder = {
      fg = colors.red;
    };
    SagaBorder = {
      bg = colors.darker_black;
    };
    SagaNormal = {
      bg = colors.darker_black;
    };

    "@lsp.type.class" = {
      link = "Structure";
    };
    "@lsp.type.decorator" = {
      link = "Function";
    };
    "@lsp.type.enum" = {
      link = "Type";
    };
    "@lsp.type.enumMember" = {
      link = "Constant";
    };
    "@lsp.type.function" = {
      link = "@function";
    };
    "@lsp.type.interface" = {
      link = "Structure";
    };
    "@lsp.type.macro" = {
      link = "@macro";
    };
    "@lsp.type.method" = {
      link = "@function.method";
    };
    "@lsp.type.namespace" = {
      link = "@module";
    };
    "@lsp.type.parameter" = {
      link = "@variable.parameter";
    };
    "@lsp.type.property" = {
      link = "@property";
    };
    "@lsp.type.struct" = {
      link = "Structure";
    };
    "@lsp.type.type" = {
      link = "@type";
    };
    "@lsp.type.typeParamater" = {
      link = "TypeDef";
    };
    "@lsp.type.variable" = {
      link = "@variable";
    };
    "@event" = {
      fg = colors.base08;
    };
    "@modifier" = {
      fg = colors.base08;
    };
    "@regexp" = {
      fg = colors.base0F;
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
