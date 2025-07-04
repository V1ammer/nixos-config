{config, ...}: {
  prefer-no-csd = true;

  spawn-at-startup = [
    {command = ["xwayland-satellite" ":12"];}
    {command = ["cosmic-notifications"];}
    {command = ["cosmic-panel"];}
  ];

  environment = {
    DISPLAY = ":12";
    NIXOS_OZONE_WL = "1";
  };

  input = {
    keyboard.xkb = {
      layout = "us,ru";
      options = "ctrl:nocaps";
    };
    touchpad = {
      tap = true;
      natural-scroll = true;
    };
    tablet.map-to-output = "eDP-1";
    touch.map-to-output = "eDP-1";
    focus-follows-mouse.enable = false;
  };

  hotkey-overlay.skip-at-startup = true;

  window-rules = [
    {
      opacity = 0.95;
      draw-border-with-background = false;
      clip-to-geometry = true;
      geometry-corner-radius.bottom-left = 10.0;
      geometry-corner-radius.bottom-right = 10.0;
      geometry-corner-radius.top-left = 10.0;
      geometry-corner-radius.top-right = 10.0;
    }
  ];

  layer-rules = [{
    matches = [{
      namespace = "wpaperd";
    }];
    place-within-backdrop = true;
  }];

  overview.workspace-shadow.enable = false;

  outputs."eDP-1" = {
    scale = 2.0;
    mode = {
      width = 3840;
      height = 2160;
      refresh = 60.0;
    };
    position = {
      x = 1920;
      y = 1080;
    };
  };

  layout = {
    background-color = "transparent";
    focus-ring.enable = false;
    insert-hint.display.color = "rgb(153, 0, 255 / 50%)";
    border = {
      enable = true;
      width = 2;
      active.color = "#4c0080";
    };
    preset-column-widths = [
      {proportion = 1.0 / 3.0;}
      {proportion = 1.0 / 2.0;}
      {proportion = 2.0 / 3.0;}
    ];
    default-column-width.proportion = 1.0 / 1.0;
    gaps = 16;
    center-focused-column = "never";
  };

  screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
  animations.slowdown = 1.2;

  binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;
    "Mod+T".action.spawn = "rio";
    "Mod+D".action.spawn = "fuzzel";
    "Mod+B".action.spawn = "google-chrome-stable";
    "Mod+Shift+T".action.spawn = "Telegram";
    "Mod+O".action.spawn = "onlyoffice-desktopeditors";
    "Mod+V".action.spawn = "AmneziaVPN";
    "Mod+Y" = {
      hotkey-overlay.title = "Spawn yazi";
      action.spawn = ["rio" "-e" "fish" "-c" "yazi"];
    };
    "Mod+Shift+B" = {
      hotkey-overlay.title = "Spawn bottom -b";
      action.spawn = ["rio" "-e" "btm" "-b"];
    };
    "Mod+Shift+Ctrl+B" = {
      hotkey-overlay.title = "Spawn bottom";
      action.spawn = ["rio" "-e" "btm"];
    };
    "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
    "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];
    "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
    "Mod+Q".action = close-window;
    "Mod+Left".action = focus-column-left;
    "Mod+Down".action = focus-window-or-workspace-down;
    "Mod+Up".action = focus-window-or-workspace-up;
    "Mod+Right".action = focus-column-right;
    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+L".action = focus-column-right;
    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Down".action = move-window-down;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Right".action = move-column-right;
    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+J".action = move-window-down;
    "Mod+Ctrl+K".action = move-window-up;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Home".action = focus-column-first;
    "Mod+End".action = focus-column-last;
    "Mod+Ctrl+Home".action = move-column-to-first;
    "Mod+Ctrl+End".action = move-column-to-last;
    "Mod+Shift+Left".action = focus-monitor-left;
    "Mod+Shift+Down".action = focus-monitor-down;
    "Mod+Shift+Up".action = focus-monitor-up;
    "Mod+Shift+Right".action = focus-monitor-right;
    "Mod+Shift+H".action = focus-monitor-left;
    "Mod+Shift+J".action = focus-monitor-down;
    "Mod+Shift+K".action = focus-monitor-up;
    "Mod+Shift+L".action = focus-monitor-right;
    "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
    "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
    "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
    "Mod+Page_Down".action = focus-workspace-down;
    "Mod+Page_Up".action = focus-workspace-up;
    "Mod+U".action = focus-workspace-down;
    "Mod+I".action = focus-workspace-up;
    "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
    "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
    "Mod+Ctrl+U".action = move-column-to-workspace-down;
    "Mod+Ctrl+I".action = move-column-to-workspace-up;
    "Mod+Shift+Page_Down".action = move-workspace-down;
    "Mod+Shift+Page_Up".action = move-workspace-up;
    "Mod+Shift+U".action = move-workspace-down;
    "Mod+Shift+I".action = move-workspace-up;
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+R".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+C".action = center-column;
    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";
    "Mod+Space".action.switch-layout = "next";
    "Mod+Shift+Space".action.switch-layout = "prev";
    "Print".action = screenshot;
    "Alt+Print".action = screenshot-window;
    "Mod+Shift+E".action = quit;
    "Mod+Shift+P".action = power-off-monitors;
  };
}
