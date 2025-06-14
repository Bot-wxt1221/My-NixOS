{
  lib,
  ...
}:
{
  imports = [

  ];
  system.stateVersion = lib.trivial.release;
  nix.settings.substituters = lib.mkForce [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
    "https://nix-community.cachix.org"
    "https://wxt1221.cachix.org"
    "https://luogu-judge.cachix.org"
    "https://niri.cachix.org"
    "https://moraxyc.cachix.org"
    "https://cache.garnix.io"
  ];
  nix.settings.narinfo-cache-positive-ttl = 3600;
  nix.settings.trusted-users = [
    "root"
    "wxt"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "wxt1221.cachix.org-1:JmeZ+5reEo1i5qBc6X+2hEadoN5GFqTOQcwaGD5PEwY="
    "luogu-judge.cachix.org-1:vBoiA0n//KfYZ5Xp5HhcujXcdT7dK3+rEK3U4zw66TQ="
    "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    "moraxyc.cachix.org-1:p00BlzhjSZq23aXYuzeUF2uXdE8ikh6tq9aV1seenhQ="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
}
