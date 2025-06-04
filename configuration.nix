{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.gvfs.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.printing.enable = false;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.excludePackages = [pkgs.xterm];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  documentation.nixos.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.displayManager.cosmic-greeter.enable = true;
  services.upower.enable = true;

  users.users.killua = {
    isNormalUser = true;
    description = "Killua";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = [];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  programs.nix-ld.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      export TERM=xterm-256color
      starship init fish | source
    '';
  };
  programs.niri = {
    enable = true;
  };
  programs.amnezia-vpn.enable = true;

  fonts.packages = with pkgs; [nerd-fonts.hack];

  virtualisation.docker.enable = true;

  home-manager.backupFileExtension = "backup";

  home-manager.users.killua = {...}: {
    imports = [
      inputs.niri.homeModules.niri
      ./home-manager/home.nix
    ];
  };

  system.stateVersion = "25.11";
  system.autoUpgrade.enable = true;
}
