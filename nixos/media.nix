{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    telegram-desktop
    loupe
    transmission_4-gtk
    tor-browser
    # kdePackages.kdenlive

    # Thorium browser
    (let
      pname = "thorium";
      version = "128.0.6613.189";
      src = fetchurl {
        url =
          "https://github.com/Alex313031/thorium/releases/download/M${version}/Thorium_Browser_${version}_AVX2.AppImage";
        hash = "sha256-RBPSGgwF6A4KXgLdn/YIrdFpZG2+KwMJ8MkTjSPpkhU=";
      };
      appimageContents =
        appimageTools.extractType2 { inherit pname version src; };
    in appimageTools.wrapType2 {
      inherit pname version src;
      extraInstallCommands = ''
        install -m 444 -D ${appimageContents}/thorium-browser.desktop $out/share/applications/thorium-browser.desktop
        install -m 444 -D ${appimageContents}/thorium.png $out/share/icons/hicolor/512x512/apps/thorium.png
        substituteInPlace $out/share/applications/thorium-browser.desktop \
        --replace 'Exec=AppRun --no-sandbox %U' 'Exec=${pname} %U'
      '';
    })

    (let
      pname = "hiddify";
      version = "2.5.7";
      src = fetchurl {
        url =
          "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
        hash = "sha256-5RqZ6eyurRtoOVTBLZqoC+ANi4vMODjlBWf3V4GXtMg=";
      };
    in appimageTools.wrapType2 {
      inherit pname version src;
      extraPkgs = pkgs: [ pkgs.libepoxy ];
    })
  ];
}
