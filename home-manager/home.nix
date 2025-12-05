{
  config,
  lib,
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
    cosmic-panel
    delta
    google-chrome
    networkmanagerapplet
    onlyoffice-desktopeditors
    swaynotificationcenter
    telegram-desktop
    v2rayn
    xwayland-satellite
    uv
    ruff
    ty
    nil
    nixd
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
      helix_mode = true;
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
      languages = {
        Python = {
          language_servers = ["ty" "ruff"];
        };
      };
      lsp = {
        ty = {
          binary = {
            path = "${lib.getExe pkgs.ty}";
            arguments = ["server"];
          };
        };
        ruff = {
          binary = {
            path = "${lib.getExe pkgs.ruff}";
            arguments = ["server"];
          };
        };
      };
    };
  };

  programs.git = {
    enable = true;
    settings.user = {
      email = "v1lammer@gmail.com";
      name = "V1ammer";
      init.defaultBranch = "master";
      pull.rebase = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
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
      cargo
      rust-analyzer
      tinymist
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
    env=TERMCMD="${lib.getExe pkgs.alacritty-graphics} -e"
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME/Downloads
  '';

  home.stateVersion = "25.11";
}
