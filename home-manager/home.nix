{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  home.enableNixpkgsReleaseCheck = false;

  home.username = "killua";
  home.homeDirectory = "/home/killua";

  home.packages = with pkgs; [
    (lib.hiPrio uutils-coreutils-noprefix)
    bottom
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
    yazi
    zellij
  ];

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
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };

  services.wpaperd = {
    enable = true;
    settings.any = {
      path = ./assets/material.jpg;
    };
  };
  programs.niri.settings = import ./niri.nix {config = config;};

  home.stateVersion = "25.11";
}
