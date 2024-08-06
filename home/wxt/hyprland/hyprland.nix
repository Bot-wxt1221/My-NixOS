{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [

  ];
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1

    $terminal = gnome-terminal
    $fileManager = nautilus -w
    $menu = wofi --show drun

    env = XCURSOR_SIZE,24
    env = HYPRCURSOR_SIZE,24
    env = LIBVA_DRIVER_NAME,nvidia
    env = XDG_SESSION_TYPE,wayland
    env = GBM_BACKEND,nvidia-drm
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia

    cursor {
      no_hardware_cursors = true
    }

    general { 
      gaps_in = 5
      gaps_out = 20

      border_size = 2

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false 

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false

      layout = dwindle
    }

    decoration {
      rounding = 10

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0
      inactive_opacity = 1.0

      drop_shadow = true
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur {
          enabled = true
          size = 3
          passes = 1
          
          vibrancy = 0.1696
      }
    }

    animations {
      enabled = true

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    dwindle {
      pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true # You probably want this
    }

    master {
      new_status = master
    }

    misc { 
      force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
    }

    input {
      kb_layout = us

      follow_mouse = 1

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

      touchpad {
          natural_scroll = true
      }
    }

    gestures {
      workspace_swipe = false
    }

    exec-once=fcitx5 --replace -d
    exec-once=clash-verge
    exec-once=hyprpaper
    exec-once=waybar
    exec-once=swaync
    exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    $mainMod = SUPER # Sets "Windows" key as main modifier

    bind = $mainMod, Q, exec, $terminal
    bind = $mainMod, C, killactive,
    bind = $mainMod, M, exit,
    bind = ALT, F4, killactive,
    bind = $mainMod, E, exec, $fileManager
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, R, exec, $menu
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle

    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    bind = $mainMod, S, togglespecialworkspace, magic
    bind = $mainMod SHIFT, S, movetoworkspace, special:magic

    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bind = $mainMod,F,submap,resize
    submap=resize

      binde=,h,resizeactive,-10 0
      binde=,l,resizeactive,10 0
      binde=,k,resizeactive,0 -10
      binde=,j,resizeactive,0 10

      bind=,escape,submap,reset
    submap=reset

    bind=SUPERSHIFT,h,movewindow,l
    bind=SUPERSHIFT,l,movewindow,r
    bind=SUPERSHIFT,j,movewindow,u
    bind=SUPERSHIFT,k,movewindow,d

    windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
  '';
}
