{ config, mainUser, nixpkgs-unstable, ... }: {
  nixpkgs.overlays = [
    (final: _: {
      dotfiles = final.runCommand "collected-dotfiles" { } ''
        mkdir -p $out
        ${builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs
          (name: value: ''
            mkdir -p $(dirname $out/${name})
            cp -r ${value.source} $out/${name}
          '') config.home-manager.users."${mainUser}".xdg.configFile))}
      '';
      unstable = import nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];
}
