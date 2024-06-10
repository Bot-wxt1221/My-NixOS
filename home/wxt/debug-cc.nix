{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  home.file.".local/share/nvim/dapinstall/ccppr_vsc/extension/debugAdapters/bin/OpenDebugAD7" = {
	source = ${pkgs.vscode-extension-ms-vscode-cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7;
	executable = true;
  }
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
            "miDebuggerPath": "{pkgs.gdb}/bin/gdb",
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

  ''
}
