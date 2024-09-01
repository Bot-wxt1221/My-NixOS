{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
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
    source-code-pro # Default monospace font in 3.32
        source-sans
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
      ];
    })
  ];
}
