{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    telegram-desktop
    loupe
    transmission_4-gtk
    tor-browser
    # hiddify-app
    # kdePackages.kdenlive

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

    # (let
    #   pname = "happ";
    #   version = "0.0.10";
    #   src = ''
    #   ${fetchzip {
    #     url =
    #       "https://github.com/Happ-proxy/happ-desktop/releases/download/alpha_${version}/Happ.linux.x86.AppImage.zip";
    #     hash = "sha256-oCPV15GHQ6IZUaTlgXWmBwTuC+ETdXH03NuPwjCZU5w=";
    #   }}/Happ.AppImage'';
    # in appimageTools.wrapType2 {
    #   inherit pname version src;
    #   extraPkgs = pkgs: [ pkgs.libepoxy pkgs.libsForQt5.qt5.qtwayland ];
    # })
  ];
}
