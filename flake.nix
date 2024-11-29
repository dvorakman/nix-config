{
  description = "dvorakman's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }:
    let
      system = "x86_64-linux";  # Adjust for your architecture
    in
    {
      nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          disko.nixosModules.disko
        ];
        specialArgs = { inherit system; };
      };

      homeConfigurations.cardinal = home-manager.lib.homeManagerConfiguration {
        system = system;
        modules = [
          ./home.nix
        ];
      };
    };
}