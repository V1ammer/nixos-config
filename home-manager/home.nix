{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.username = "killua";
  home.homeDirectory = "/home/killua";

  home.packages = with pkgs; [
    (lib.hiPrio uutils-coreutils-noprefix)
    bottom
    brightnessctl
    cosmic-applets
    cosmic-applibrary
    cosmic-notifications
    cosmic-panel
    cosmic-settings
    fuzzel
    google-chrome
    networkmanagerapplet
    onlyoffice-bin
    telegram-desktop
    xwayland-satellite
  ];

  programs.zellij = {
    enable = true;
    attachExistingSession = true;
    enableFishIntegration = true;
    exitShellOnExit = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
    };
  };

  programs.yazi = {
    enable = true;
    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = true;
      };
    };
  };

  programs.zoxide.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.rio = {
    enable = true;
    settings = {
      theme = "TokyoNight";
      window = {
        decorations = "Disabled";
        mode = "maximized";
        blur = true;
      };
      env-vars = ["TERM=xterm-256color"];
      confirm-before-quit = false;
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "python" "dockerfile" "yaml" "toml" "git-firefly"];
    userSettings = {
      vim_mode = true;
      telemetry = {
        metrics = false;
      };
      theme = "Tokyo Night";
      format_on_save = "off";
    };
  };

  programs.git = {
    enable = true;
    userEmail = "v1lammer@gmail.com";
    userName = "V1ammer";
    extraConfig.init.defaultBranch = "master";
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  services.wpaperd = {
    enable = true;
    settings.any = {
      path = ./assets/material.jpg;
    };
  };
  programs.niri.settings = import ./niri.nix {config = config;};

  programs.helix = import ./helix.nix {pkgs = pkgs;};

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
    ];
  };

  home.stateVersion = "25.11";
}
