{ pkgs, lib, ... }:
let upkgs = pkgs.unstable;
in {
  home.packages = with upkgs; [ nixd ];
  # Helix editor default choose
  programs.helix = {
    enable = true;
    defaultEditor = true;

    package = upkgs.helix;

    languages = {
      language = [{
        name = "nix";
        auto-format = true;

        formatter = { command = lib.getExe upkgs.nixfmt-classic; };
      }];
    };
  };
}
