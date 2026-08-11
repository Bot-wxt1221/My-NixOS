_: {
  security = {
    sudo.enable = false;
    polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };
    run0 = {
      enable = true;
      sudo-shim = {
        enable = true;
      };
    };
  };
  system.tools.nixos-rebuild.enableRun0Elevation = true;
}
