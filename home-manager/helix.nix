{ pkgs, lib, ... }: {
  home.packages = with pkgs; [ nixd ];
  # Helix editor default choose
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language = [{
        name = "nix";
        auto-format = true;

        formatter = { command = lib.getExe pkgs.nixfmt-classic; };
      }];
    };
  };
}
