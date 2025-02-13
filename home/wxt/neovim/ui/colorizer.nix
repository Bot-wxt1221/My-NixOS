{
  programs.nixvim.plugins.colorizer = {
    enable = true;
    settings.user_default_options = {
      AARRGGBB = false;
      RGB = true;
      RRGGBB = true;
      RRGGBBAA = true;
      css = true;
      css_fn = true;
      hsl_fn = true;
      mode = "background";
      names = true;
      rgb_fn = true;
      tailwind = true;
    };
  };
}
