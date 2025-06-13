{
  description = "My system conf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    solaar = {
      url = "github:Svenum/Solaar-Flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    disko.url = "github:nix-community/disko";
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix/release-25.05";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
  };

  outputs = { nixpkgs, home-manager, nixos-hardware, disko, nur, stylix, chaotic
    , betterfox, solaar, vscode-extensions, ... }@inputs:
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
          solaar.nixosModules.default
          # hyprland.nixosModules.default
          { nixpkgs.overlays = [ vscode-extensions.overlays.default ]; }

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
