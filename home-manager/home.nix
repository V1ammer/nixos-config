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
    networkmanagerapplet
    swaynotificationcenter
    bottom
    fuzzel
    pavucontrol
    pcmanfm
    google-chrome
    networkmanager-l2tp
    neovim
    niri
    onlyoffice-bin
    telegram-desktop
    rio
    yazi
    zellij
  ];

  home.file.".config/rio/config.toml".text = ''
    [window]
    mode = "maximized"
    opacity = 0.9
  '';

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "python" "dockerfile" "yaml" "toml" "git-firefly"];
    userSettings = {
      vim_mode = true;
      telemetry = {
        metrics = false;
      };
      theme = "One Dark";
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

  programs.ironbar = {
    enable = true;
    systemd = true;
    config = import ./ironbar.nix;
    style = builtins.readFile ./ironbar.css;
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
