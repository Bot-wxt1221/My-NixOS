_: {
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      autoLoad = true;
      setupLspCapabilities = true;
    };
  };
}
