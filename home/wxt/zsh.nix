{ config,pkgs, ... }:
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
    };
    history.size = 100000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
  home.file.".wakatime/wakatime-cli" = {
    source = "${pkgs.wakatime-cli}/bin/wakatime-cli";
    executable = true;
  };
  home.file."wakatime-cli-linux-amd64" = {
    source = "${pkgs.wakatime-cli}/bin/wakatime-cli";
    executable = true;
  };
}
