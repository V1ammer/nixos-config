{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.enableNixpkgsReleaseCheck = false;

  home.username = "killua";
  home.homeDirectory = "/home/killua";

  services.battery-notifier = {
    enable = true;
    settings = {
      interval_ms = 1000;
      reminder = {threshold = 15;};
      warn = {threshold = 10;};
      threat = {threshold = 5;};
    };
  };

  home.packages = with pkgs; [
    bottom
    brightnessctl
    comma
    cosmic-applets
    cosmic-notifications
    cosmic-panel
    cosmic-settings
    delta
    google-chrome
    nerd-fonts.hack
    networkmanagerapplet
    onlyoffice-bin
    telegram-desktop
    xwayland-satellite
    uutils-coreutils-noprefix
    uv
  ];

  programs.alacritty = {
    package = pkgs.alacritty-graphics;
    enable = true;
    theme = "tokyo_night";
    settings.env.TERM = "xterm-256color";
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor_git;
    extensions = ["nix" "python" "dockerfile" "yaml" "toml" "git-firefly"];
    userSettings = {
      vim_mode = true;
      telemetry = {
        metrics = false;
      };
      theme = "One Dark";
      format_on_save = "off";
      remove_trailing_whitespace_on_save = false;
      ensure_final_newline_on_save = false;
      features = {
        edit_prediction_provider = "none";
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs.zellij = {
    enable = true;
    settings = {
      pane_frames = false;
      show_startup_tips = false;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "v1lammer@gmail.com";
    userName = "V1ammer";
    extraConfig = {
      init.defaultBranch = "master";
      pull.rebase = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;  # use n and N to move between diff sections
        dark = true;
      };
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
    enableFishIntegration = true;
  };

  programs.yazi.enable = true;

  programs.zoxide.enable = true;

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

  programs.niri = {
    package = pkgs.niri_git;
    settings = import ./niri.nix {config = config;};
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.helix_git;
    settings.theme = "tokyonight";
    extraPackages = with pkgs; [
      gcc
      nil
      nixd
      cargo
      rust-analyzer
      ruff
      pyright
      ty
      tinymist
    ];
    languages.language = [
      {
        name = "python";
        language-servers = ["pyright" "ruff" "ty"];
      }
    ];
  };

  xdg.portal = {
    enable = true;
    config.common = {
      default = ["gnome"];
      "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-termfilechooser
    ];
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    env=TERMCMD="alacritty -e"
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME/Downloads
  '';

  home.stateVersion = "25.11";
}
