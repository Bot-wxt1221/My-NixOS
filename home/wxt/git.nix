{ config, pkgs, ... }:
{
  imports = [

  ];
  programs.git = {
    enable = true;
    userName = "wxt";
    userEmail = "3264117476@qq.com";
    extraConfig = {
      commit = { gpgsign = true; };
      user = { signingKey = "30A417022236AF61A3745C1C0DD874925162B3DB"; };
    };
  };
}
