{ pkgs, ... }: { 
  environment.systemPackages = with pkgs; [
    telegram-desktop
    loupe
    transmission_4-gtk
    vlc
    tor-browser

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
      version = "2.0.5";
      src = fetchurl {
        url =
          "https://github.com/hiddify/hiddify-next/releases/download/v${version}/Hiddify-Linux-x64.AppImage";
        hash = "sha256-zVwSBiKYMK0GjrUpPQrd0PaexJ4F2D9TNS/Sk8BX4BE=";
      };
    in appimageTools.wrapType2 {
      inherit name version src;
      extraPkgs = pkgs: [ pkgs.libepoxy ];
    })
  ];
}
