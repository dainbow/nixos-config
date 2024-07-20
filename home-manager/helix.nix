{ pkgs, ... }: {
  # Helix editor default choose
  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language = [{
        name = "nix";

        language-servers = [ "nixd" ];
      }];

      language-server.nixd = { command = "${pkgs.nixd}/bin/nixd"; };
    };
  };
}
