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
        specialArgs = { inherit inputs mainUser hostname nixpkgs-unstable; };

        modules = [
          chaotic.nixosModules.default
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          nur.modules.nixos.default
          disko.nixosModules.disko

          ./nixos/module.nix

          {
            home-manager = {
              extraSpecialArgs = { inherit inputs mainUser; };
              useGlobalPkgs = true;
              users."${mainUser}" = {
                imports =
                  [ betterfox.homeModules.betterfox ./home-manager/home.nix ];
              };
            };
          }
        ];
      };
    };
}
