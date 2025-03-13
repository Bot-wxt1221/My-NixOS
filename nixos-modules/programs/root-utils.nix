{
  pkgs,
  ...
}:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    nano
    vim
    wget
  ];
}
