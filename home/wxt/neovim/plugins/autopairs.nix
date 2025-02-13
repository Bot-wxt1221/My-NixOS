{
  programs.nixvim.plugins.nvim-autopairs = {
    enable = true;
    settings.disabled_filetype = [
      "TelescopePrompt"
      "vim"
    ];
  };
}
