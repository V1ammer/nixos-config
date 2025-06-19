{
  config,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home.enableNixpkgsReleaseCheck = false;

  home.username = "killua";
  home.homeDirectory = "/home/killua";

  home.packages = with pkgs; [
    (lib.hiPrio uutils-coreutils-noprefix)
    bottom
    brightnessctl
    cosmic-applets
    cosmic-notifications
    cosmic-panel
    fuzzel
    google-chrome
    nerd-fonts.hack
    networkmanagerapplet
    onlyoffice-bin
    telegram-desktop
    xwayland-satellite
  ];

  fonts.fontconfig.enable = true;

  programs.zellij = {
    enable = true;
    settings = {
      show_startup_tips = false;
    };
  };

  programs.git = {
    enable = true;
    userEmail = "v1lammer@gmail.com";
    userName = "V1ammer";
    extraConfig.init.defaultBranch = "master";
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

  home.file.".config/rio/themes/TokyoNight.toml".source = ./assets/rio_themes/TokyoNight.toml;

  programs.rio = {
    enable = true;
    settings = {
      theme = "TokyoNight";
      fonts.regular = {
        family = "Hack Nerd Font";
      };
      window = {
        mode = "maximized";
        blur = true;
      };
      env-vars = ["TERM=xterm-256color"];
      confirm-before-quit = false;
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

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix.packages.${pkgs.system}.default;
    settings.theme = "tokyonight";
    extraPackages = with pkgs; [
      nil
      nixd
      cargo
      rust-analyzer
      ruff
      pyright
      tinymist
    ];
    languages.language = [
      {
        name = "python";
        language-servers = ["pyright" "ruff"];
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
    env=TERMCMD="rio -e"
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME/Downloads
  '';

  home.stateVersion = "25.11";
}
