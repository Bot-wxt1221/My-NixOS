{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  fonts.fontconfig = {
    defaultFonts = {
      emoji = [
        "Noto Color Emoji"
      ];
      monospace = [
        "Source Code Pro"
        "emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "emoji"
      ];
      serif = [
        "Noto Serif"
        "emoji"
      ];
    };
  };
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    wqy_microhei
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
    cantarell-fonts
    dejavu_fonts
    source-code-pro
    source-sans
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
