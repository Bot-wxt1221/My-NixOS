{
  sops.defaultSopsFile = ./secret.yaml.after;
  sops.defaultSopsFormat = "yaml";
  sops.secrets.wxt-password = {
    neededForUsers = true;
    mode = "0400";
  };
  sops.secrets.GOOGLE_API_KEY = {
    neededForUsers = true;
    mode = "0444";
  };
  sops.secrets.GOOGLE_DEFAULT_CLIENT_ID = {
    neededForUsers = true;
    mode = "0444";
  };
  sops.secrets.GOOGLE_DEFAULT_CLIENT_SECRET = {
    neededForUsers = true;
    mode = "0444";
  };
}
