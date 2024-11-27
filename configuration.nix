{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${builtins.fetchTarball {
      url = "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
    }}/nixos"
  ];

  system.stateVersion = "24.05";

  networking.hostName = "idios";

  home-manager.users.myuser = {
    home.stateVersion = "24.05";
    imports = [ ./home.nix ];
  };

  environment.systemPackages = with pkgs; [
    vim git curl wget
  ];

  services.xserver.enable = true;
  services.xserver.windowManager.hyprland.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulseaudio.enable = true;
  };

}