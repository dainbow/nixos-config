{ pkgs, ... }: {
  services.fprintd = {
    enable = true;
    package = pkgs.fprintd.overrideAttrs (super: {
      buildInputs = [
        pkgs.glib
        pkgs.polkit
        pkgs.nss
        pkgs.pam
        pkgs.systemd

        (pkgs.stdenv.mkDerivation {
          pname = "libfprint";
          version = "1.94.1";
          outputs = [ "out" "devdoc" ];

          src = pkgs.fetchFromGitHub {
            owner = "dainbow";
            repo = "libfprint";
            rev = "eedbd24a624b5032a14a2d28ff62eb2df5dedd2f";
            sha256 = "sha256-N6kQI1ogoYSMmPwD+fr6ti0sJtEh7kzlpYKP6WsRN08=";
          };

          nativeBuildInputs = with pkgs; [
            pkg-config
            meson
            ninja
            cmake
            gtk-doc
            docbook-xsl-nons
            docbook_xml_dtd_43
            gobject-introspection
          ];

          buildInputs = with pkgs; [
            gusb
            pixman
            glib
            nss
            cairo
            libgudev
            openssl
          ];

          mesonFlags = [
            "-Dudev_rules_dir=${placeholder "out"}/lib/udev/rules.d"
            # Include virtual drivers for fprintd tests
            "-Ddrivers=all"
            "-Dudev_hwdb_dir=${placeholder "out"}/lib/udev/hwdb.d"
          ];

          nativeInstallCheckInputs = with pkgs;
            [ (python3.withPackages (p: with p; [ pygobject3 ])) ];

          # We need to run tests _after_ install so all the paths that get loaded are in
          # the right place.
          doCheck = false;

          doInstallCheck = false;

          installCheckPhase = ''
            runHook preInstallCheck

            ninjaCheckPhase

            runHook postInstallCheck
          '';
        })
      ];
    });
  };
}
