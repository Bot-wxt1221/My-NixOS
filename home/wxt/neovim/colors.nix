{ config, lib, ... }:
let
  palette = config.colorScheme.palette;

  max = x: y: if x > y then x else y;
  min = x: y: if x < y then x else y;
  decToHex =
    let
      intToHex = [
        "0"
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "a"
        "b"
        "c"
        "d"
        "e"
        "f"
      ];
      toHex' =
        q: a: if q > 0 then (toHex' (q / 16) ((builtins.elemAt intToHex (lib.mod q 16)) + a)) else a;
    in
    v: toHex' v "";

  rgbToHex =
    rgb:
    let
      hexList = builtins.map decToHex rgb;
      hexColor = builtins.concatStringsSep "" hexList;
    in
    hexColor;

  pow =
    let
      pow' =
        base: exponent: value:
        if exponent == 0 then
          1
        else if exponent <= 1 then
          value
        else
          (pow' base (exponent - 1) (value * base));
    in
    base: exponent: pow' base exponent base;

  hexToDec =
    v:
    let
      hexToInt = {
        "0" = 0;
        "1" = 1;
        "2" = 2;
        "3" = 3;
        "4" = 4;
        "5" = 5;
        "6" = 6;
        "7" = 7;
        "8" = 8;
        "9" = 9;
        "a" = 10;
        "b" = 11;
        "c" = 12;
        "d" = 13;
        "e" = 14;
        "f" = 15;
      };
      chars = lib.stringToCharacters v;
      charsLen = lib.length chars;
    in
    lib.foldl (a: v: a + v) 0 (
      lib.imap0 (k: v: hexToInt."${lib.toLower v}" * (pow 16 (charsLen - k - 1))) chars
    );

  hexToRGB =
    color:
    let
      hexList = [
        (builtins.substring 0 2 color)
        (builtins.substring 2 2 color)
        (builtins.substring 4 2 color)
      ];
    in
    map hexToDec hexList;

  darken =
    color: percentage:
    let
      factor = 1.0 - (percentage / 100.0);
      rgb = hexToRGB color;
      newRGB = map (x: max 0 (min 255 (builtins.floor (factor * x)))) rgb;
    in
    rgbToHex newRGB;
in
{
  white = "#${palette.base07}";
  black = "#${palette.base00}";
  darkest_black = "#${darken palette.base00 18}";
  darker_black = "#${darken palette.base00 12}";
  black2 = "#${darken palette.base00 (-18)}";
  one_bg = "#${palette.base02}";
  one_bg2 = "#${palette.base02}";
  one_bg3 = "#${palette.base03}";
  grey = "#${darken palette.base00 (-80)}";
  grey_fg = "#${darken palette.base00 (-120)}";
  grey_fg2 = "#${darken palette.base00 (-140)}";
  light_grey = "#${darken palette.base02 (-18)}";
  red = "#${palette.base08}";
  baby_pink = "#${darken palette.base0E 6}";
  pink = "#${palette.base0E}";
  line = "#${darken palette.base00 (-30)}";
  green = "#${darken palette.base0B (-12)}";
  vibrant_green = "#${palette.base0B}";
  dark_blue = "#${darken palette.base0D (18)}";
  nord_blue = "#${darken palette.base0D (-12)}";
  blue = "#${palette.base0D}";
  yellow = "#${palette.base0A}";
  sun = "#${darken palette.base0A 6}";
  purple = "#${darken palette.base0E 12}";
  dark_purple = "#${darken palette.base0E 18}";
  teal = "#${darken palette.base0C 6}";
  orange = "#${palette.base09}";
  cyan = "#${palette.base0C}";
  statusline_bg = "#${darken palette.base01 6}";
  lightbg = "#${palette.base01}";
  pmenu_bg = "#${darken palette.base0C (-6)}";
  folder_bg = "#${darken palette.base0D 12}";
}
// builtins.mapAttrs (_name: value: "#" + value) palette
