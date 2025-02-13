{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".local/share/OpenDebugAD7/OpenDebugAD7".source =
    "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";
  home.file.".local/share/OpenDebugAD7/OpenDebugAD7".executable = true;
  home.file."OI/Temp.cpp".text = ''
    #include <iostream>
    #include <cstdio>
    inline int read();

    signed main(){
      #ifndef ONLINE_JUDGE
      freopen(".in","r",stdin);
      freopen(".out","w",stdout);
      #endif
      
      return 0;
    }
    inline int read(){
      int f=1,x=0;
      char temp=getchar();
      while(temp>'9'||temp<'0'){
        (temp=='-')?(f=-1):0;
        temp=getchar();
      }
      while('0'<=temp&&temp<='9'){
        x=(x<<3)+(x<<1)+(temp^'0');
        temp=getchar();
      }
      return f*x;
    }
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
