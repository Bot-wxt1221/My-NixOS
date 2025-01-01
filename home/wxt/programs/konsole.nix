{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".local/share/konsole/Profile 1.profile" = {
    text = ''
      [Appearance]
      Font=JetBrains Mono,13.5,-1,5,50,0,0,0,0,0

      [General]
      Name=Profile 1
      Parent=
    '';
  };
  home.file.".config/konsolerc" = {
    text = ''
      [Desktop Entry]
      DefaultProfile=Profile 1.profile

      [General]
      ConfigVersion=1

      [MainWindow]
      1920x1080 screen: Height=982
      1920x1080 screen: Width=934
      RestorePositionForNextInstance=false
      State=AAAA/wAAAAD9AAAAAQAAAAAAAAAAAAAAAPwCAAAAAvsAAAAiAFEAdQBpAGMAawBDAG8AbQBtAGEAbgBkAHMARABvAGMAawAAAAAA/////wAAAYMBAAAD+wAAABwAUwBTAEgATQBhAG4AYQBnAGUAcgBEAG8AYwBrAAAAAAD/////AAABIQEAAAMAAAOmAAADpwAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIBAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAQAAAOD/////AAAAAAAAAAA=
      ToolBarsMovable=Disabled

      [UiSettings]
      ColorScheme=
    '';
  };
}
