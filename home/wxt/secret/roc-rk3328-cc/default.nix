{
  config,
  ...
}:

{
  sops.defaultSopsFile = ./secret.yaml.after;
  sops.secrets.ssh_key = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519";
    mode = "0400";
  };
  sops.secrets.ssh_key_pub = {
    path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
    mode = "0400";
  };
  sops.secrets.github_token = {
    mode = "0400";
  };
}
