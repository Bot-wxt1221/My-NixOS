{
  config,
  pkgs,
  nix-colors,
  lib,
  ...
}:
{
  imports = [
    nix-colors.homeManagerModules.colorScheme
  ];
  colorScheme = lib.mkDefault nix-colors.colorSchemes.google-light;
  home.file."update.sh".text = ''
    cd ~/Working/config
    git pull
    git add .
    sudo echo hello
    nix flake prefetch
    nh os switch . -- --log-format internal-json -v --option narinfo-cache-negative-ttl 1200
    git add .
    git commit -m "Update"
    git push origin master
  '';
  home.file."update.sh".executable = true;
}
