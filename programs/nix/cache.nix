{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  system.stateVersion = "unstable"; # Did you read the comment?
  nix.settings.substituters = [
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://nix-community.cachix.org"
    "https://wxt1221.cachix.org"
    "https://cuda-maintainers.cachix.org"
    "https://luogu-judge.cachix.org"
    "https://hyprland.cachix.org"
  ];
  nix.settings.trusted-users = [
    "root"
    "wxt"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "wxt1221.cachix.org-1:JmeZ+5reEo1i5qBc6X+2hEadoN5GFqTOQcwaGD5PEwY="
    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    "luogu-judge.cachix.org-1:vBoiA0n//KfYZ5Xp5HhcujXcdT7dK3+rEK3U4zw66TQ="
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
}
