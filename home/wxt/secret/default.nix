{
  config,
  ...
}:

{
  imports = [
    ./2FA
  ];
  sops.age.keyFile = "/persist/home/wxt/.config/sops/age/key.txt";
  home.activation.copy-keys = ''
    mkdir -p /home/wxt/.config/sops/age/
    cp ${config.sops.age.keyFile} /home/wxt/.config/sops/age/keys.txt
  '';
}
