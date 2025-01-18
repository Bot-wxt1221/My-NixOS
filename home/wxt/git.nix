{ config, pkgs, ... }:
{
  imports = [

  ];
  programs.git = {
    enable = true;
    userName = "wxt";
    userEmail = "3264117476@qq.com";
  };
  home.persistence."/persist/home/wxt" = {
    directories = [
      ".config/gh"
    ];
  };
}
