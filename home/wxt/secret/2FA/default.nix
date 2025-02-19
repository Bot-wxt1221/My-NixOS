{
  config,
  ...
}:

{
  sops.secrets.passwordDateBase = {
    format = "binary";
    sopsFile = ./pas2s.kdbx.after;
    path = "${config.home.homeDirectory}/2FA/pas2s.kdbx";
    mode = "0400";
  };
  sops.secrets.passwordDateBaseSecret = {
    format = "binary";
    sopsFile = ./kee.after;
    path = "${config.home.homeDirectory}/2FA/kee";
    mode = "0400";
  };
}
