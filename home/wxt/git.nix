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
      user = { signingKey = "7D01C38E6B886424C0A51B348281D5EE2D1825A4"; };
    };
  };
}
