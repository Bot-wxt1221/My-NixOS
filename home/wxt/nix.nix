{ config, pkgs, ... }:
{

  home.file."update.sh".text = ''
    cd ~/config
    git pull
    git add .
    bash "/home/wxt/update2.sh" |& nom --json
    git add .
    git commit -m "Update"
    git push origin master
  '';
  home.file."update.sh".executable = true;
  home.file."update2.sh".text = ''
    sudo nixos-rebuild switch --flake . --log-format internal-json -v
  '';
  home.file."update2.sh".executable = true;

}
