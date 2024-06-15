{ config, pkgs, lib, ... }:

let mainUser = "dainbow";
in {
  imports = [ # Include the results of the hardware scan.
    <nixos-hardware/asus/zephyrus/ga401>
    ./hardware-configuration.nix
    "${
      builtins.fetchTarball
      "https://github.com/nix-community/disko/archive/master.tar.gz"
    }/module.nix"
    ./disk-config.nix
    <home-manager/nixos>
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Default hostname
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networkmanager  
  networking.networkmanager.enable = true;

  # Hack to enable VPN work
  networking.nameservers = [ "1.1.1.1" ];
  networking.firewall.enable = false;
  networking.resolvconf.dnsExtensionMechanism = false;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable zsh (should use even with home-manager)
  programs.zsh.enable = true;

  # Default shell is zsh
  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;

  # Define a user account. 
  users.users.dainbow = {
    isNormalUser = true;
    home = "/home/${mainUser}";
    hashedPassword =
      "$6$9IC0fdnfmsnoOEbg$.jGDMrzeKvaembPfo.31XSjbQkyvHtVg8zPM494SBJMhF8iPkxpXG1nfXDe9E6fY3/KkoLezFVUnoHmB.7Dj80";
    extraGroups = [ "wheel" "input" "networkmanager" ];
  };

  # Enable Gnome with gdm autologin
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    displayManager = {
      autoLogin = {
        enable = true;
        user = mainUser;
      };
    };
  };

  # Certain user config
  home-manager.users.dainbow = { lib, pkgs, ... }: {
    # GTK Theme choose + dark mode
    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
        name = "palenight";
        package = pkgs.palenight-theme;
      };

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

    };

    # My git info 
    programs.git = {
      enable = true;
      userName = mainUser;
      userEmail = "suslov9876@gmail.com";
    };

    # Alacritty theme
    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.95;

        font = {
          size = 13.0;
          normal = {
            family = "JetBrains Mono";
            style = "Bold";
          };
        };

        colors.primary.background = "#1d2021";
      };
    };

    # Zsh config with aliases
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        l = "exa -la";
        c = "clear";
        update =
          "sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
      };
    };

    # Starship (zsh wrapper) config
    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;

        sudo = { disabled = false; };

        memory_usage = {
          disabled = false;
          threshold = 50;
        };

        os = { disabled = false; };
      };
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # Helix editor default choose
    programs.helix = {
      enable = true;
      defaultEditor = true;
    };

    # Better top enable
    programs.btop = { enable = true; };

    # Install gnome extensions for my users
    home.packages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.just-perfection
      gnomeExtensions.status-area-horizontal-spacing
      gnomeExtensions.vitals
      gnomeExtensions.weather-oclock
    ];

    # Dconf settings
    dconf.settings = with lib.hm.gvariant; {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # Enable extensions I use
        enabled-extensions = [
          "Vitals@CoreCoding.com"
          "just-perfection-desktop@just-perfection"
          "blur-my-shell@aunetx"
          "appindicatorsupport@rgcjonas.gmail.com"
          "weatheroclock@CleoMenezesJr.github.io"
          "dash-to-dock@micxgx.gmail.com"
        ];
        # Pined dock apps
        favorite-apps = [
          "thorium-browser.desktop"
          "org.telegram.desktop.desktop"
          "code.desktop"
          "transmission-gtk.desktop"
          "Alacritty.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
      # Common settings (dark mode, battery, seconds)
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
        clock-show-seconds = true;
      };
      # Keyboard layouts
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
      };
      # Override default alt-tab behaviour
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
      "org/gnome/desktop/wm/preferences" = {
        button-layout = ":minimize,maximize,close";
      };
      # Custom shortcut for terminal
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" =
        {
          binding = "<Super>t";
          command = "alacritty";
          name = "Term";
        };
      # Vitals (system info) extension config
      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = [
          "_memory_usage_"
          "__network-rx_max__"
          "_battery_rate_"
          "_processor_usage_"
        ];
        show-storage = true;
        show-voltage = true;
        show-memory = true;
        show-fan = false;
        show-temperature = false;
        show-processor = true;
        show-network = true;
        show-battery = true;
      };
      # Weather config
      "org/gnome/shell/weather" = { automatic-location = true; };
      "org/gnome/GWeather4" = { temperature-unit = "centigrade"; };
    };

    # DO NOT TOUCH
    home.stateVersion = "24.11";
  };

  # My packages
  environment.systemPackages = with pkgs; [
    # Development stuff
    git
    vscode
    nil
    nixfmt-classic
    clang-tools
    typst-lsp
    helix
    rust-analyzer
    yaml-language-server
    taplo
    marksman
    cmake-language-server
    bash-language-server

    # Terminal stuff
    alacritty
    zsh
    starship

    # Multimedia
    telegram-desktop

    # Gnome themes and default apps
    papirus-folders
    papirus-icon-theme
    palenight-theme
    loupe
    gnome.gnome-weather
    gnome.nautilus

    # Better CLI tools
    fd
    ripgrep
    dust
    eza
    bat

    # Better nerd tools
    btop
    fastfetch
    nvtopPackages.full

    # Media stuff
    transmission-gtk
    vlc

    # Thorium browser
    (let
      name = "thorium";
      version = "124.0.6367.218";
      src = fetchurl {
        url =
          "https://github.com/Alex313031/thorium/releases/download/M${version}/Thorium_Browser_${version}_AVX2.AppImage";
        hash = "sha256-y15pJWps+CdU9zNz+8eobBv09ENHJmUt14d9D+tzj98=";
      };
      appimageContents = appimageTools.extractType2 { inherit name src; };
    in appimageTools.wrapType2 {
      inherit name version src;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
        install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
        substituteInPlace $out/share/applications/thorium-browser.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${name} %U'
      '';
    })

    (let
      name = "hiddify";
      version = "1.4.0";
      src = fetchurl {
        url =
          "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
        hash = "sha256-EY89VbK/alSeluf5PWbsufaPrN701Jy8LOuFbGnxEjs=";
      };
    in appimageTools.wrapType2 {
      inherit name version src;
      extraPkgs = pkgs: [ pkgs.libepoxy ];
    })
  ];

  # Automatic collect garbage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  # Enable nix search/store
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages (NVIDIA)
  nixpkgs.config.allowUnfree = true;

  # Gnome Files hack to see video metadata
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope (gself: gsuper: {
        nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
          buildInputs = nsuper.buildInputs
            ++ (with pkgs.gst_all_1; [ gst-plugins-good gst-plugins-bad ]);
        });
      });
    })
  ];

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);

  # Btrfs stuff
  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  # Minimal gnome apps
  services.gnome.core-utilities.enable = false;
  services.gnome.games.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  # Autologin fixup
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # System fonts
  fonts.packages = with pkgs; [
    fira-code
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "FiraCode" ]; })
  ];

  # Do not touch
  system.stateVersion = "24.11";
}

