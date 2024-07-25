{ pkgs, lib, ... }: {
  # Enable Gnome
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      excludePackages = [ pkgs.xterm ];
    };

    # Minimal gnome apps
    gnome = {
      core-utilities.enable = false;
      games.enable = false;
      core-developer-tools.enable = false;
    };
  };

  environment.systemPackages = (with pkgs.gnome; [ gnome-weather ]);

  # Gnome Files hack to see video metadata
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope (gself: gsuper: {
        mutter = gsuper.mutter.overrideAttrs (old: {
          src = pkgs.fetchFromGitLab {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-46";
            hash = "sha256-nz1Enw1NjxLEF3JUG0qknJgf4328W/VvdMjJmoOEMYs=";
          };
        });
      });
    })
  ];

  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);
}
