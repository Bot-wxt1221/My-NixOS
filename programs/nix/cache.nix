{ config, lib, pkgs, ... }:
{
  imports = [

  ];
  system.stateVersion = "unstable"; # Did you read the comment?
  nix.settings.substituters = ["https://mirrors.ustc.edu.cn/nix-channels/store" "https://nix-community.cachix.org" "https://wxt1221.cachix.org"];
  nix.settings.trusted-users = ["root" "wxt"];
  nix.settings.trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "wxt1221.cachix.org-1:KR3i2n9P8aIYE5a7+nUOHLhxz4jQ2IvdVUncYmvHXqM="];
}
