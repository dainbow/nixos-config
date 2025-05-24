{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = with pkgs;
      (let
        pname = "thorium";
        version = "130.0.6723.174";
        src = fetchurl {
          url =
            "https://github.com/Alex313031/thorium/releases/download/M${version}/Thorium_Browser_${version}_AVX2.AppImage";
          hash = "sha256-Ej7OIdAjYRmaDlv56ANU5pscuwcBEBee6VPZA3FdxsQ=";
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
      });

    extensions = let
      uBlock = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      privacyBadger = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
    in [ uBlock privacyBadger ];
  };
}
