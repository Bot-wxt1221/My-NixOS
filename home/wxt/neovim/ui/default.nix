{ config, lib, ... }:
let
  colors = import ../colors.nix { inherit config lib; };
in
{
  imports = [
    ./bufferline.nix
    ./colorizer.nix
    ./lualine.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./term.nix
  ];

  programs.nixvim.colorschemes.base16 = {
    enable = true;
    colorscheme = builtins.mapAttrs (_name: value: "#" + value) config.colorScheme.palette;
  };

  programs.nixvim.keymaps = [
    {
      mode = [ "n" ];
      key = "<leader>n";
      action = "<cmd>set nu!<CR>";
      options = {
        desc = "Toggle Line number";
      };
    }
    {
      mode = [ "n" ];
      key = "<leader>rn";
      action = "<cmd>set rnu!<CR>";
      options = {
        desc = "Toggle Relative number";
      };
    }
  ];

  programs.nixvim.plugins.web-devicons.enable = true;

  programs.nixvim.highlight = {
    MatchWord = {
      bg = colors.grey;
      fg = colors.white;
    };
    Pmenu = {
      bg = colors.one_bg;
    };
    PmenuSbar = {
      bg = colors.one_bg;
    };
    PmenuSel = {
      bg = colors.pmenu_bg;
      fg = colors.black;
    };
    PmenuThumb = {
      bg = colors.grey;
    };
    MatchParen = {
      link = "MatchWord";
    };
    Comment = {
      fg = colors.grey_fg;
      italic = false;
    };
    CursorLineNr = {
      fg = colors.white;
    };
    LineNr = {
      fg = colors.grey;
    };
    FloatBorder = {
      fg = colors.blue;
    };
    NormalFloat = {
      bg = colors.darker_black;
    };
    NvimInternalError = {
      fg = colors.red;
    };
    WinSeparator = {
      fg = colors.line;
    };
    Normal = {
      fg = colors.base05;
      bg = colors.base00;
    };
    DevIconDefault = {
      fg = colors.red;
    };
    Bold = {
      bold = true;
    };
    Debug = {
      fg = colors.base08;
    };
    Directory = {
      fg = colors.base0D;
    };
    Error = {
      fg = colors.base00;
      bg = colors.base08;
    };
    ErrorMsg = {
      fg = colors.base08;
      bg = colors.base00;
    };
    Exception = {
      fg = colors.base08;
    };
    FoldColumn = {
      fg = colors.base0C;
      bg = colors.base01;
    };
    Folded = {
      fg = colors.light_grey;
      bg = colors.black2;
    };
    IncSearch = {
      fg = colors.base01;
      bg = colors.base0A;
    };
    Italic = {
      italic = true;
    };
    Macro = {
      fg = colors.base08;
    };
    ModeMsg = {
      fg = colors.base0B;
    };
    MoreMsg = {
      fg = colors.base0B;
    };
    Question = {
      fg = colors.base0D;
    };
    Search = {
      fg = colors.base01;
      bg = colors.base09;
    };
    Substitute = {
      fg = colors.base01;
      bg = colors.base0A;
      sp = "none";
    };
    SpecialKey = {
      fg = colors.base03;
    };
    TooLong = {
      fg = colors.base08;
    };
    UnderLined = {
      underline = true;
    };
    Visual = {
      bg = colors.base02;
    };
    VisualNOS = {
      fg = colors.base08;
    };
    WarningMsg = {
      fg = colors.base08;
    };
    WildMenu = {
      fg = colors.base08;
      bg = colors.base0A;
    };
    Title = {
      fg = colors.base0D;
      sp = "none";
    };
    Conceal = {
      bg = "NONE";
    };
    Cursor = {
      fg = colors.base00;
      bg = colors.base05;
    };
    NonText = {
      fg = colors.base03;
    };
    SignColumn = {
      fg = colors.base03;
      sp = "NONE";
    };
    ColorColumn = {
      bg = colors.black2;
    };
    CursorColumn = {
      bg = colors.base01;
      sp = "none";
    };
    CursorLine = {
      bg = colors.black2;
    };
    QuickFixLine = {
      bg = colors.base01;
      sp = "none";
    };
    SpellBad = {
      undercurl = true;
      sp = colors.base08;
    };
    SpellLocal = {
      undercurl = true;
      sp = colors.base0C;
    };
    SpellCap = {
      undercurl = true;
      sp = colors.base0D;
    };
    SpellRare = {
      undercurl = true;
      sp = colors.base0E;
    };
    healthSuccess = {
      bg = colors.green;
      fg = colors.black;
    };
    DevIconc = {
      fg = colors.blue;
    };
    DevIconcss = {
      fg = colors.blue;
    };
    DevIcondeb = {
      fg = colors.cyan;
    };
    DevIconDockerfile = {
      fg = colors.cyan;
    };
    DevIconhtml = {
      fg = colors.baby_pink;
    };
    DevIconjpeg = {
      fg = colors.dark_purple;
    };
    DevIconjpg = {
      fg = colors.dark_purple;
    };
    DevIconjs = {
      fg = colors.sun;
    };
    DevIconkt = {
      fg = colors.orange;
    };
    DevIconlock = {
      fg = colors.red;
    };
    DevIconlua = {
      fg = colors.blue;
    };
    DevIconmp3 = {
      fg = colors.white;
    };
    DevIconmp4 = {
      fg = colors.white;
    };
    DevIconout = {
      fg = colors.white;
    };
    DevIconpng = {
      fg = colors.dark_purple;
    };
    DevIconpy = {
      fg = colors.cyan;
    };
    DevIcontoml = {
      fg = colors.blue;
    };
    DevIconts = {
      fg = colors.teal;
    };
    DevIconttf = {
      fg = colors.white;
    };
    DevIconrb = {
      fg = colors.pink;
    };
    DevIconrpm = {
      fg = colors.orange;
    };
    DevIconvue = {
      fg = colors.vibrant_green;
    };
    DevIconwoff = {
      fg = colors.white;
    };
    DevIconwoff2 = {
      fg = colors.white;
    };
    DevIconxz = {
      fg = colors.sun;
    };
    DevIconzip = {
      fg = colors.sun;
    };
    DevIconZig = {
      fg = colors.orange;
    };
    DevIconMd = {
      fg = colors.blue;
    };
    DevIconTSX = {
      fg = colors.blue;
    };
    DevIconJSX = {
      fg = colors.blue;
    };
    DevIconSvelte = {
      fg = colors.red;
    };
    DevIconJava = {
      fg = colors.orange;
    };
    DevIconDart = {
      fg = colors.cyan;
    };
  };
}
