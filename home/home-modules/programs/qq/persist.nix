{
  config,
  ...
}:
{
  preservation.preserveAt."/persist".users.wxt = {
    directories = [
      ".config/QQ"
    ];
  };
}
