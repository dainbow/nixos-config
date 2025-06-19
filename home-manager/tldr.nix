{ pkgs, ... }:
let tldrPackage = pkgs.tlrc;
in {
  home.packages = [ tldrPackage ];

  services.tldr-update = {
    enable = true;
    package = tldrPackage;
    period = "daily";
  };
}
