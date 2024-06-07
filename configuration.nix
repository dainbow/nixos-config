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

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Default hostname
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networkmanager  
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable zsh (should use even with home-manager)
  programs.zsh.enable = true;

  # Default shell is zsh
  users.defaultUserShell = pkgs.zsh;
  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dainbow = {
    isNormalUser = true;
    home = "/home/${mainUser}";
    hashedPassword =
      "$6$9IC0fdnfmsnoOEbg$.jGDMrzeKvaembPfo.31XSjbQkyvHtVg8zPM494SBJMhF8iPkxpXG1nfXDe9E6fY3/KkoLezFVUnoHmB.7Dj80";
    extraGroups =
      [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

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

  home-manager.users.dainbow = { lib, pkgs, ... }: {
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

    programs.git = {
      enable = true;
      userName = mainUser;
      userEmail = "suslov9876@gmail.com";
    };

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

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        l = "exa -la";
        c = "clear";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
      };
    };

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

    programs.helix = {
      enable = true;
      defaultEditor = true;
    };

    programs.btop = { enable = true; };

    home.packages = with pkgs; [
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.dash-to-dock
      gnomeExtensions.just-perfection
      gnomeExtensions.status-area-horizontal-spacing
      gnomeExtensions.vitals
      gnomeExtensions.weather-oclock
    ];

    dconf.settings = with lib.hm.gvariant; {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        # `gnome-extensions list` for a list
        enabled-extensions = [
          "Vitals@CoreCoding.com"
          "just-perfection-desktop@just-perfection"
          "blur-my-shell@aunetx"
          "appindicatorsupport@rgcjonas.gmail.com"
          "weatheroclock@CleoMenezesJr.github.io"
          "dash-to-dock@micxgx.gmail.com"
        ];
        favorite-apps = [
          "thorium-browser.desktop"
          "org.telegram.desktop.desktop"
          "code.desktop"
          "transmission-gtk.desktop"
          "Alacritty.desktop"
          "org.gnome.Nautilus.desktop"
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        show-battery-percentage = true;
        clock-show-seconds = true;
      };
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) (mkTuple [ "xkb" "ru" ]) ];
      };
      "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = [ ];
        switch-applications-backward = [ ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
      };
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
      "org/gnome/shell/weather" = { automatic-location = true; };
      "org/gnome/GWeather4" = { temperature-unit = "centigrade"; };
    };

    home.stateVersion = "24.11";
  };

  environment.systemPackages = with pkgs; [
    # Development stuff
    git
    typst
    vscode
    nil
    nixfmt-classic
    clang-tools
    helix

    # Terminal stuff
    alacritty
    zsh
    starship

    # Multimedia
    telegram-desktop
    v2raya

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

    # Better nerd tools
    btop
    fastfetch

    # Media stuff
    transmission-gtk
    vlc

    # AppImage git apps
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
      extraPkgs = pkgs: [
        pkgs.libepoxy
        pkgs.libayatana-indicator
        pkgs.libdbusmenu
      ];
    })
  ];

  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 =
    lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);

  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;

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

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";

  services.gnome.core-utilities.enable = false;
  services.gnome.games.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "FiraCode" ]; })
  ];

  system.stateVersion = "24.11"; # Did you read the comment?
}

