{
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
{
  options = {
    cpuTempDevice = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
    haveBacklight = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  imports = [ ./waybar-style.nix ];
  config =
    let
      niri-taskbar = pkgs.nur.repos.linyinfeng.niri-taskbar;
    in
    {
      programs.waybar = {
        enable = true;
        systemd.enable = true;
      };
      home.packages = with pkgs; [
        pamixer
        pavucontrol
        pwvucontrol
        ponymix
        blueberry
        pantheon.switchboard-with-plugs
      ];
      programs.waybar.settings.mainBar = {
        position = "bottom";
        layer = "top";
        height = 27;
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        modules-left = [
          "custom/launcher"
          "niri/workspaces"
          "cffi/niri-taskbar"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
        ]
        ++ lib.optionals (!builtins.isNull config.cpuTempDevice) [
          "temperature"
        ]
        ++ [
          "cpu"
          "memory"
          "disk"
        ]
        ++ lib.optionals (osConfig.Enablepipewire or osConfig.Enablepulseaudio) [
          "pulseaudio"
        ]
        ++ lib.optionals config.haveBacklight [
          "backlight"
        ]
        ++ [
          "network"
        ]
        ++ lib.optionals osConfig.EnableBluetooth [
          "bluetooth"
        ]
        ++ lib.optionals osConfig.Laptop [
          "battery"
        ]
        ++ [
          "custom/notification"
        ];
        backlight = lib.optionals config.haveBacklight {
          device = "intel_backlight";
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
          ];
        };
        "niri/window" = {
          icon = false;
        };
        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%Y/%m/%d (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b> 一   二   三   四   五   六   日                 一   二   三   四   五   六   日                 一   二   三   四   五   六   日</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        "cffi/niri-taskbar" = {
          module_path = "${niri-taskbar}/lib/libniri_taskbar.so";
          apps = {
            signal = [
              {
                match = "\\([0-9]+\\)$";
                class = "unread";
              }
            ];
          };
        };
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            browser = "";
            discord = "";
            chat = "<b></b>";
            active = "";
            default = "";
          };
        };
        bluetooth = lib.mkIf osConfig.EnableBluetooth {
          format-on = "";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "<b>󰂰 {num_connections}</b>";
          format-connected-battery = "󰥄 {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "blueberry";
        };
        memory = {
          format = "󰟜 {}%";
          format-alt = "󰟜 {used} GiB"; # 
          interval = 2;
        };
        cpu = {
          format = "  {usage}%";
          format-alt = "  {avg_frequency} GHz";
          interval = 2;
        };
        disk = {
          # path = "/";
          format = "󰋊 {percentage_used}%";
          interval = 60;
        };
        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰀂 ";
          tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
          format-linked = "{ifname} (No IP)";
          format-disconnected = "󰖪 ";
          on-click = "io.elementary.settings";
        };
        tray = {
          icon-size = 21;
          spacing = 8;
        };
        pulseaudio = lib.mkIf (osConfig.Enablepipewire or osConfig.Enablepulseaudio) {
          format = "{icon} {volume}%";
          format-muted = "  {volume}%";
          format-icons = {
            default = [ " " ];
          };
          scroll-step = 5;
          on-click =
            if osConfig.Enablepipewire then
              "${pkgs.pwvucontrol}/bin/pwvucontrol"
            else if osConfig.Enablepulseaudio then
              "${pkgs.pavucontrol}/bin/pavucontrol"
            else
              null;
        };
        battery = lib.mkIf osConfig.Laptop {
          format = "{icon} {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
          format-charging = " {capacity}%";
          format-full = " {capacity}%";
          format-warning = " {capacity}%";
          interval = 5;
          states = {
            warning = 20;
          };
          format-time = "{H}h{M}m";
          tooltip = true;
          tooltip-format = "{time}";
        };
        "custom/launcher" = {
          format = "";
          on-click = "fuzzel";
          tooltip = "false";
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon} ";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>   ";
            none = "   ";
            dnd-notification = "<span foreground='red'><sup></sup></span>   ";
            dnd-none = "   ";
            inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
            inhibited-none = "   ";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
            dnd-inhibited-none = "   ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        "temperature" = lib.optionals (!builtins.isNull config.cpuTempDevice) {
          hwmon-path = config.cpuTempDevice;
          critical-threshold = 80;
          format-critical = " {temperatureC}°C";
          on-click = "niri msg action toggle-overview";
          format = " {temperatureC}°C";
        };
      };
    };
}
