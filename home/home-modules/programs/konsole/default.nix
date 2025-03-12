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
      BorderWhenActive=false
      ColorScheme=Breeze
      Font=JetBrains Mono,14.7,-1,5,400,0,0,0,0,0,0,0,0,0,0,1
      LineSpacing=0
      UseFontLineChararacters=false

      [General]
      DimWhenInactive=false
      Name=Profile 1

      [Interaction Options]
      MiddleClickPasteMode=1

      [Scrolling]
      HistoryMode=2

      [Terminal Features]
      VerticalLine=false
    '';
  };
  home.file.".config/konsolerc" = {
    text = ''
      [Desktop Entry]
      DefaultProfile=Profile 1.profile

      [General]
      ConfigVersion=1

      [MainWindow]
      RestorePositionForNextInstance=false
      State=AAAA/wAAAAD9AAAAAQAAAAAAAAAAAAAAAPwCAAAAAvsAAAAiAFEAdQBpAGMAawBDAG8AbQBtAGEAbgBkAHMARABvAGMAawAAAAAA/////wAAAYMBAAAD+wAAABwAUwBTAEgATQBhAG4AYQBnAGUAcgBEAG8AYwBrAAAAAAD/////AAABIQEAAAMAAAOmAAADpwAAAAQAAAAEAAAACAAAAAj8AAAAAQAAAAIAAAACAAAAFgBtAGEAaQBuAFQAbwBvAGwAQgBhAHIBAAAAAP////8AAAAAAAAAAAAAABwAcwBlAHMAcwBpAG8AbgBUAG8AbwBsAGIAYQByAQAAAOD/////AAAAAAAAAAA=
      ToolBarsMovable=Disabled
    '';
  };
}
