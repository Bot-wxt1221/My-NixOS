{
  ...
}:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    autoLoad = true;
    settings.extensions = [ "nvim-dap-ui" ];
    settings.options = {
      globalstatus = true;
      icons_enabled = true;
      theme = "gruvbox_light";
      section_separators = {
        right = "";
        left = "▊ ";
      };
      component_separators = {
        left = "";
        right = "";
      };
    };
  };
}
