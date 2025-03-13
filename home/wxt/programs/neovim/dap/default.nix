{
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins = {
      dap-python.enable = true;
      dap-ui = {
        enable = true;
        settings = {
          expand_lines = true;
          floating = {
            mappings = {
              close = [
                "q"
                "<ESC>"
              ];
            };
            max_height = 0.9;
            max_width = 0.5;
            border = "single";
          };
          mappings = {
            expand = [
              "<CR>"
              "<2-LeftMouse>"
            ];
            open = "o";
            remove = "d";
            edit = "e";
            repl = "r";
            toggle = "t";
          };
          icons = {
            collapsed = "";
            current_frame = "";
            circular = "";
            expanded = "";
          };
        };
      };
      dap = {
        enable = true;
        signs = {
          dapBreakpoint = {
            text = "●";
            texthl = "DapBreakpoint";
          };
          dapBreakpointCondition = {
            text = "●";
            texthl = "DapBreakpointCondition";
          };
          dapLogPoint = {
            text = "◆";
            texthl = "DapLogPoint";
          };
        };

        adapters = {
          executables = {
            # lldb = {
            # 	command = "${pkgs.lldb_18}/bin/lldb-vscode";
            # };
            "cppdbg" = {
              command = "${
                (pkgs.vscode-extensions.ms-vscode.cpptools.overrideAttrs (old: {
                  postPatch =
                    old.postPatch
                    + ''
                      cp debugAdapters/bin/cppdbg.ad7Engine.json debugAdapters/bin/nvim-dap.ad7Engine.json
                    '';
                }))
              }/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
            };
          };
        };
      };
    };
    keymaps = import ./dap-key.nix;
    extraConfigLua = # lua
      ''
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      '';
  };
}
