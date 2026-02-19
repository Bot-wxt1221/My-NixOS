_:{
  programs.nixvim.plugins.lsp.servers.rust_analyzer = {
    enable = true;
    installRustc = false;
    installCargo = false;
  };
}
