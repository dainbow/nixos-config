{ config, lib, pkgs, ... }:

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
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

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

  home-manager.users.dainbow = { pkgs, ... }: {
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

    home.stateVersion = "24.11";
  };

  environment.systemPackages = with pkgs; [
    vim
    wget

    # Development stuff
    git

    # Terminal stuff
    alacritty
    zsh

    firefox
    telegram-desktop

    # Gnome stuff
    papirus-folders
    papirus-icon-theme

    gnome.gnome-tweaks
    gnome.gnome-weather
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    gnomeExtensions.status-area-horizontal-spacing
    gnomeExtensions.vitals
    gnomeExtensions.weather-oclock

    starship
    eza
    dust
    fastfetch
    helix
    nixfmt-classic

    # Tops!
    btop

    vscode
    transmission-gtk
    vlc
    krusader
    loupe

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
    in appimageTools.wrapType2 { inherit name version src; })
  ];

  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

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

