{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    disko.url = "github:nix-community/disko";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    hosts.url = "github:StevenBlack/hosts";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, disko, nur, stylix, hosts
    , chaotic, hyprland, betterfox, ... }@inputs:
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
          nur.nixosModules.nur
          disko.nixosModules.disko
          hyprland.nixosModules.default

          (hosts.nixosModule {
            config.networking.stevenBlackHosts = {
              enable = true;
              blockFakenews = true;
              blockGambling = true;
              blockPorn = false;
              blockSocial = false;
            };
          })

          ./nixos/module.nix

          {
            home-manager = {
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
