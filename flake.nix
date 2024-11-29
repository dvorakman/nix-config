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
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    nixosConfigurations.mySystem = nixpkgs.lib.nixosSystem {
      system = system;
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        disko.nixosModules.disko
      ];
    };

    checks = {
      "${system}" = {
        nixosConfiguration = self.nixosConfigurations.mySystem.config.system.build.toplevel;
      };
    };
  }