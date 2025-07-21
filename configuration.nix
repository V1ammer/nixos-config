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
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25" "netrom" "rose"
    # Old or rare or insufficiently audited filesystems
    "adfs" "affs" "bfs" "befs" "cifs" "cramfs" "efs" "erofs" "exofs"
    "freevxfs" "f2fs" "gfs2" "hfs" "hfsplus" "hpfs" "jffs2" "jfs" "ksmbd"
    "minix" "nfsv4" "nfsv3" "nfs" "omfs" "qnx4" "qnx6" "squashfs" "sysv"
    "udf" "vivid" "nilfs2"
    # Something else
    "af_802154" "appletalk" "atm" "can" "dccp" "decnet" "econet"
    "firewire-core" "ipx" "n-hdlc" "p8022" "p8023" "psnap"
    "rds" "sctp" "thunderbolt" "tipc" "x25"
    # Bluetooth
    #"bluetooth" "btusb" "btrtl" "btintel" "btbcm" "btmtk"
    # Unused sensors
    "kfifo_buf" "industrialio" "industrialio_triggered_buffer" "cm32181"
    "hid_sensor_als" "hid_sensor_hub" "hid_sensor_trigger" "hid_sensor_iio_common"
    # Unused io
    "joydev" # joystick
    "mac_hid" # mac mouse
    "ee1004" # spd eeprom
    "loop" # loop mounted devices
    # FireWire
    "firewire-core" "firewire-ohci" "firewire-sbp2"
  ];
  boot.kernelParams = [
    "mitigations=off"

    "acpi_backlight=amdgpu"
    "amdgpu.dc=1"
  ];

  services.dbus.enable = true;
  services.scx.enable = true;
  services.gvfs.enable = true;
  services.earlyoom.enable = true;

  services.thermald = {
    enable = true;
    ignoreCpuidCheck = true;
  };
  services.tlp.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
      wheelNeedsPassword = true;
    };
  };

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

  environment.defaultPackages = [];

  networking.hostName = "nixos";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
    ];
  };

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

  nixpkgs.overlays = [inputs.niri.overlays.niri];

  services.xserver.excludePackages = [pkgs.xterm];

  documentation = {
    nixos.enable = false;
    man.generateCaches = false;
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.upower.enable = true;

  programs.amnezia-vpn.enable = true;
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.niri = {
    enable = true;
    package = pkgs.niri_git;
  };

  users.users.killua = {
    isNormalUser = true;
    description = "Killua";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = pkgs.fish;
  };

  # niri-flake adds it on nixos level,Add commentMore actions
  # but I wish to configure it on home-manager level
  xdg.portal.enable = false;
  
  virtualisation.docker.enable = true;

  home-manager.backupFileExtension = "backup";

  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.users.killua = {...}: {
    imports = [
      inputs.battery-notifier.homeManagerModule.default
      inputs.chaotic.homeManagerModules.default
      inputs.niri.homeModules.niri
      ./home-manager/home.nix
    ];
  };

  networking.firewall.enable = true;

  system.stateVersion = "25.11";
  system.autoUpgrade.enable = true;
}
