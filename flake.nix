{
  description = "dvorakman's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    # Optionally add more inputs like a custom NixOS flake
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";  # Adjust for your architecture
    in
    {
      nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./configuration.nix  # Include your main system configuration
          ./hardware-configuration.nix  # Include hardware config
        ];
        specialArgs = { inherit system; };
      };

      homeConfigurations.cardinal = home-manager.lib.homeManagerConfiguration {
        system = system;
        modules = [
          ./home.nix  # Include your user-specific configuration here
        ];
      };
    };
}