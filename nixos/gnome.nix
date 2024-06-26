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

  environment.systemPackages = with pkgs.gnome; [ gnome-weather nautilus ];

  # Gnome Files hack to see video metadata
  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope (gself: gsuper: {
        nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
          buildInputs = nsuper.buildInputs
            ++ (with pkgs.gst_all_1; [ gst-plugins-good gst-plugins-bad ]);
        });

        mutter = gsuper.mutter.overrideAttrs (old: {
          src = pkgs.fetchFromGitLab  {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-46";
            hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
          };
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

  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);
}
