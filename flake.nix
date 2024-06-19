{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, disko, ... }@inputs:
    let 
      mainUser = "dainbow";
      hostname = "nixos";
    in {
      nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs mainUser hostname; };

        modules = [
          nixos-hardware.nixosModules.asus-zephyrus-ga401
          disko.nixosModules.disko
          ./nixos/module.nix
        ];
      };

      homeConfigurations."${mainUser}" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit mainUser; };
        
        modules = [  
          ./home-manager/home.nix
        ];
      }; 
    };
}
