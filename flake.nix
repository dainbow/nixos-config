{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # lix = {
    #   url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    disko.url = "github:nix-community/disko";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, disko, nur, stylix
    ,  ... }@inputs:
    let
      mainUser = "dainbow";
      hostname = "dainix";
    in {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs mainUser hostname; };

        modules = [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager 
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          nur.nixosModules.nur
          disko.nixosModules.disko
          # lix.nixosModules.default
          ./nixos/module.nix

          {
            home-manager = {             
              users."${mainUser}" = {             
                imports = [ ./home-manager/home.nix ];
              };
            };
          }
        ];
      };
    };
}
