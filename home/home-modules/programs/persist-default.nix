_: {
  imports = [
    ./qq/persist.nix
    ./thunderbird/persist.nix
  ];
  preservation.preserveAt."/persist".users.wxt = {
    directories = [
      ".config/rustdesk"
      ".local/share/com.example.piliplus"
      ".local/state/dms"
      ".local/state/wireplumber"
      ".config/kdeconnect"
      ".config/warp"
    ];
  };
}
