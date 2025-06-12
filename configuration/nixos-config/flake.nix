{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      unstable = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
            config.allowUnfree = true;
          };
          inherit inputs system unstable spicetify-nix;
        };
        modules = [
          spicetify-nix.nixosModules.spicetify  
          ./nixos/configuration.nix
        ];
      };
    };
}
