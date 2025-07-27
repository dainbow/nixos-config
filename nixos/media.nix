{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      loupe
      transmission_4-gtk
      tor-browser
      davinci-resolve
      handbrake
      yt-dlp
      # hiddify-app
      # kdePackages.kdenlive

      # (let
      #   pname = "hiddify";
      #   version = "2.5.7";
      #   src = fetchurl {
      #     url =
      #       "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
      #     hash = "sha256-5RqZ6eyurRtoOVTBLZqoC+ANi4vMODjlBWf3V4GXtMg=";
      #   };
      # in appimageTools.wrapType2 {
      #   inherit pname version src;
      #   extraPkgs = pkgs: [ pkgs.libepoxy ];
      # })

      (let
        pname = "happ";
        version = "0.1.2_alpha";
        src = fetchurl {
          url =
            "https://github.com/Happ-proxy/happ-desktop/releases/download/${version}/Happ.linux.x86.AppImage";
          hash = "sha256-Sz4LE2vP+nreqzQWAcuF5pGxLC68TYZ4yCvxQO6MYK0=";
        };
      in appimageTools.wrapType2 {
        inherit pname version src;

        nativeBuildInputs = [ pkgs.makeWrapper ];
        extraInstallCommands = ''
          wrapProgram $out/bin/happ --unset QT_QPA_PLATFORMTHEME --unset QT_STYLE_OVERRIDE --unset QT_QPA_PLATFORM
        '';
      })
    ] ++ (with pkgs.unstable; [ telegram-desktop ]);
}
