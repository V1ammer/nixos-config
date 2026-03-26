{
  inputs,
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

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true;
    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
    profiles."default" = {
      isDefault = true;
      search.default = "duckduckgo";
      keyboardShortcuts = [
        {
          id = "zen-compact-mode-toggle";
          key = "s";
          modifiers = {
            control = true;
            alt = true;
          };
        }
      ];
      settings = {
        "browser.tabs.hoverPreview.enabled" = true;
        "zen.welcome-screen.seen" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;

        # https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js
        # fastfox GENERAL

        # https://github.com/yokoffing/Betterfox/blob/310cbdee6ca20eb881749a559cb572ce9272a981/Fastfox.js#L17
        "nglayout.initialpaint.delay" = 1000;
        "nglayout.initialpaint.delay_in_oopif" = 1000;

        "gfx.content.skia-font-cache-size" = 32;

        "content.switch.threshold" = 500000;

        # fastfox GFX RENDERING TWEAKS

        "gfx.webrender.all" = true;
        "gfx.webrender.precache-shaders" = true;
        "gfx.webrender.compositor" = true;
        "gfx.webrender.compositor.force-enabled" = true;

        "gfx.webrender.layer-compositor" = true;
        "media.wmf.zero-copy-nv12-textures-force-enabled" = true;  # for AMD CPU

        "gfx.canvas.accelerated.cache-items" = 32768;
        "gfx.canvas.accelerated.cache-size" = 4096;

        "webgl.max-size" = 16384;

        # fastfox DISK CACHE

        "browser.cache.disk.enable" = false;

        # fastfox MEMORY CACHE

        "browser.cache.memory.capacity" = 131072;
        "browser.cache.memory.max_entry_size" = 20480;

        "browser.sessionhistory.max_total_viewers" = 4;
        "dom.storage.default_quota" = 20480;

        # fastfox MEDIA CACHE

        "media.memory_cache_max_size" = 262144;
        "media.memory_caches_combined_limit_kb" = 1048576;

        "media.cache_readahead_limit" = 600;
        "media.cache_resume_threshold" = 300;

        # fastfox IMAGE CACHE

        "image.cache.size" = 10485760;
        "image.mem.decode_bytes_at_a_time" = 65536;

        # fastfox NETWORK

        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.request.max-start-delay" = 5;

        "network.http.pacing.requests.enabled" = false;

        "network.dnsCacheEntries" = 10000;
        "network.dnsCacheExpiration" = 3600;

        "network.ssl_tokens_cache_capacity" = 10240;

        # fastfox SPECULATIVE LOADING

        "network.http.speculative-parallel-limit" = 0;

        "network.dns.disablePrefetch" = true;
        "network.dns.disablePrefetchFromHTTPS" = true;

        "browser.urlbar.speculativeConnect.enabled" = false;
        "browser.places.speculativeConnect.enabled" = false;

        "network.prefetch-next" = false;

        "network.predictor.enable-hover-on-ssl" = false;  # should be default?

        # fastfox TAB UNLOAD

        "browser.tabs.unloadOnLowMemory" = true;  # should be default?
        "browser.low_commit_space_threshold_mb" = 13107;  # is this too much?
        "browser.low_commit_space_threshold_percent" = 20;
        "browser.tabs.min_inactive_duration_before_unload" = 300000;

        # https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
        # smoothfox NATURAL SMOOTH SCROLLING V3

        "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2";
        "general.smoothScroll.currentVelocityWeighting" = "1";
        "general.smoothScroll.stopDecelerationWeighting" = "1";
      };
      mods = [
        "a6335949-4465-4b71-926c-4a52d34bc9c0"  # Better Find Bar
        "f4866f39-cfd6-4498-ab92-54213b8279dc"  # Animations Plus
        "642854b5-88b4-4c40-b256-e035532109df"  # Transparent Zen
        "2317fd93-c3ed-4f37-b55a-304c1816819e"  # Audio Indicator Enhanced
        "72f8f48d-86b9-4487-acea-eb4977b18f21"  # Better CtrlTab Panel
        "c01d3e22-1cee-45c1-a25e-53c0f180eea8"  # Ghost Tabs
        "ae7868dc-1fa1-469e-8b89-a5edf7ab1f24"  # Load Bar
        "664c54f9-d97d-410b-a479-23dd8a08a628"  # Better Tab Indicators
        "87196c08-8ca1-4848-b13b-7ea41ee830e7"  # Tab Preview Enhanced
        "81fcd6b3-f014-4796-988f-6c3cb3874db8"  # Zen Context Menu
      ];
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        adnauseam
        darkreader
        enhanced-h264ify
        github-file-icons
        refined-github
        return-youtube-dislikes
        stylus
        ublock-origin
      ];
    };
  };

  programs.zed-editor = {
    enable = true;
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

  programs.yazi= {
    enable = true;
    shellWrapperName = "y";
  };

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

  home.file.".config/niri/config.kdl".text = builtins.readFile ./niri-config.kdl;

  programs.helix = {
    enable = true;
    defaultEditor = true;
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
      "org.freedesktop.impl.portal.FileChooser" = ["termfilepickers"];
    };
    extraPortals = [
      # pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  services.xdg-desktop-portal-termfilepickers = {
    enable = true;
    package = inputs.xdp-termfilepickers.packages.${pkgs.system}.default;
    config = {
      terminal_command = [(lib.getExe pkgs.alacritty-graphics) "-e"];
    };
  };

  home.stateVersion = "25.11";
}
