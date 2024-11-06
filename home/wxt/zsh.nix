{ config, pkgs, ... }:
{
  imports = [

  ];
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    zplug = {
      enable = true;
      plugins = [ { name = "sobolevn/wakatime-zsh-plugin"; } ];
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "bira";
    };
    shellAliases = {
      l = "ls -l";
      rm = "${pkgs.trash-cli}/bin/trash-put";
    };
    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
