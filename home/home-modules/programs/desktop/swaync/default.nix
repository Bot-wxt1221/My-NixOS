{
  ...
}:
{
  imports = [

  ];
  services.swaync = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ./swaync.json);
    style = ./swaync.css;
  };
}
