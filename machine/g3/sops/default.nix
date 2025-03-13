_:

{
  sops.defaultSopsFile = ./secret.yaml.after;
  sops.defaultSopsFormat = "yaml";
  sops.secrets.wxt-password = {
    neededForUsers = true;
    mode = "0400";
  };
}
