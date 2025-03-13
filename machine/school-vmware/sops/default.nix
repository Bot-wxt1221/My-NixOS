_:

{
  sops = {
    defaultSopsFile = ./secret.yaml.after;
    defaultSopsFormat = "yaml";
    secrets.wxt-password = {
      neededForUsers = true;
      mode = "0400";
    };
  };

}
