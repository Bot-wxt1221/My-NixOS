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
    bash "/home/wxt/update2.sh" |& nom --json
    git add .
    git commit -m "Update"
    git push origin master
  '';
  home.file."update.sh".executable = true;
  home.file."update2.sh".text = ''
    sudo nixos-rebuild switch --flake . --log-format internal-json -v --option narinfo-cache-negative-ttl 1200
  '';
  home.file."update2.sh".executable = true;

}
