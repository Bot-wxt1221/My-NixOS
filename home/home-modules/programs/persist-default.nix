_: {
  imports = [
    ./qq/persist.nix
    ./thunderbird/persist.nix
  ];
  preservation.preserveAt."/persist".users.wxt = {
    directories = [
      ".config/rustdesk"
      ".config/noctalia"
    ];
  };
}
