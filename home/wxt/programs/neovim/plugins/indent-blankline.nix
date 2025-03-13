_:
{
  programs.nixvim.plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "│";
      };
      scope = {
        char = "│";
      };
      exclude = {
        buftypes = [
          "terminal"
          "quickfix"
        ];
        filetypes = [
          "checkhealth"
          "help"
          "lspinfo"
          "TelescopePrompt"
          "TelescopeResults"
        ];
      };
    };
  };
}
