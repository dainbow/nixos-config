{ pkgs, lib, ... }: {
  # Helix editor default choose
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language = [{
        name = "nix";
        auto-format = true;

        language-servers = [ "nixd" ];
        formatter = {
          command = lib.getExe pkgs.nixfmt-classic;
        };
      }];

      language-server = {
        nixd.command = lib.getExe pkgs.nixd; 
      };
    };
  };
}
