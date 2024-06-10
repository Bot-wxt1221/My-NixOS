{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file.".local/share/nvim/lazy/NvChad/lua/nvchad/configs/dap/init.lua".text = ''
    local M = {}

local function configure()
end

local function configure_exts()
end

local function configure_debuggers()
end

function M.setup()
	configure() -- Configuration
	configure_exts() -- Extensions
	configure_debuggers() -- Debugger
  require("nvchad.configs.dap.keymap").setup()
  require("nvchad.configs.dap.ui").setup()
  require("nvchad.configs.dap.icon").setup()
--  require("dap.ext.vscode").load_launchjs(nil, { cppdbg = { "c", "cpp", "rust" } })
  local dap = require('dap')
  dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7',
  }
end

configure_debuggers()

return M

  '';
  home.file."OI/.vscode/launch.json".text = ''
{
    "version": "0.2.0",
    "configurations": [

       {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "program": "''${fileDirname}/''${fileBasenameNoExtension}",
            "args": [],
            "stopAtEntry": false,
            "cwd": "''${fileDirname}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "miDebuggerPath": "${pkgs.gdb}/bin/gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": true
                }
            ]
        }
    ]
}

  '';
}
