_: {
  imports = [
    ./qq/persist.nix
    ./thunderbird/persist.nix
  ];
  preservation.preserveAt."/persist".users.wxt = {
    directories = [
      ".config/rustdesk"
      ".local/share/com.example.piliplus"
      ".local/state/DankMaterialShell"
      ".local/state/wireplumber"
      ".config/kdeconnect"
      ".config/warp"
    ];
  };
}
