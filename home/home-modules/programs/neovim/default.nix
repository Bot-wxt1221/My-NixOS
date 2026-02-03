{
  pkgs,
  neovim,
  nixVim,
  lib,
  ...
}:
{
  # imports = [ nvchad.homeManagerModule ];
  #  programs.neovim = {
  #    enable = true;
  #    package = neovim.packages.${pkgs.system}.default;
  #  };
  # programs.nvchad = {
  #  enable = true;
  #  neovim = neovim.packages.${pkgs.system}.default;
  #    gcc = luogu-gcc.packages.x86_64-linux.gcc-930;
  #  extraPackages = with pkgs; [ clang-tools ];
  #};
  #home.packages = with pkgs; [ clang-tools ];
  #home.persistence."/persist/home/wxt" = {
  #  directories = [
  #    ".local/share/nvim"
  #    ".local/state/nvim"
  #  ];
  #};
  imports = [
    ./lsp
    ./dap
    ./plugins
    ./treesitter.nix
    ./ui
    nixVim.homeModules.nixvim
  ];
  home.file.".local/share/applications/nvim.desktop" = lib.mkForce {
    text = ''
      [Desktop Entry]
      Name=Neovim wrapper
      GenericName=Text Editor
      TryExec=nvim
      Exec=konsole -e nvim %F
      Terminal=false
      Type=Application
      Keywords=Text;editor;
      Icon=nvim
      Categories=Utility;TextEditor;
      StartupNotify=false
      MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
    '';
  };
  programs.nixvim = {
    enable = true;
    #    package = neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    extraConfigLua = ''
      vim.cmd("nnoremap d \"_d")
      vim.cmd("xnoremap d \"_d")
    '';
  };
}
