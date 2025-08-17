{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-simple-tag = {
      url = "github:boydaihungst/simple-tag.yazi";
      flake = false;
    };

    yazi-torrent-preview = {
      url = "github:kirasok/torrent-preview.yazi";
      flake = false;
    };

    yazi-mediainfo = {
      url = "github:boydaihungst/mediainfo.yazi";
      flake = false;
    };

    disko.url = "github:nix-community/disko";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix/release-25.05";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, disko, nur, stylix, chaotic
    , betterfox, nixpkgs-unstable, ... }@inputs:
    let
      mainUser = "dainbow";
      hostname = "dainix";
    in {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs mainUser hostname; };

        modules = [
          chaotic.nixosModules.default
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          nur.modules.nixos.default
          disko.nixosModules.disko
          # hyprland.nixosModules.default
          {
            nixpkgs.overlays = [
              (final: _: {
                unstable = import nixpkgs-unstable {
                  inherit (final.stdenv.hostPlatform) system;
                  inherit (final) config;
                };
              })
            ];
          }

          ./nixos/module.nix

          {
            home-manager = {
              extraSpecialArgs = { inherit inputs; };
              useGlobalPkgs = true;
              users."${mainUser}" = {
                imports = [
                  betterfox.homeManagerModules.betterfox
                  ./home-manager/home.nix
                ];
              };
            };
          }
        ];
      };
    };
}
