{
  pkgs,
  ...
}:
{
  imports = [

  ];
  environment.systemPackages = with pkgs; [
    (rustdesk-flutter.overrideAttrs (old: {
      postPatch = old.postPatch or "" + ''
        substituteInPlace ../libs/scrap/src/wayland/pipewire.rs \
          --replace-fail "org.freedesktop.portal.Desktop" "org.freedesktop.portal.Desktop-for-rustdesk"
      '';
    }))
  ];
}
