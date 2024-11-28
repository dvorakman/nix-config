{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./disk-config.nix
    ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking settings
  networking.hostName = "idios";  # Define your hostname
  networking.networkmanager.enable = true;  # Enable NetworkManager

  # Time zone and locale settings
  time.timeZone = "Australia/Sydney";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # X11 and display settings
  services.xserver.enable = true;  # Enable X11
  services.displayManager.sddm.enable = true;  # SDDM display manager for Plasma
  services.desktopManager.plasma6.enable = true;  # KDE Plasma 6
  services.xserver.xkb = {
    layout = "us";
    variant = "dvorak";  # Set Dvorak as the keymap for X11
  };

  # Console keymap
  console.keyMap = "dvorak";  # Set Dvorak as the keymap for the console

  # CUPS printing service
  services.printing.enable = true;

  # Audio settings with PipeWire
  hardware.pulseaudio.enable = false;  # Disable PulseAudio (use PipeWire instead)
  security.rtkit.enable = true;  # Enable real-time privileges for PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define user account (example: cardinal)
  users.users.cardinal = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      git
    ];
    initialPassword = "aoeu";
  };

  # Enable Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages (empty for now, can be populated later)
  environment.systemPackages = with pkgs; [
    # Add additional packages here
  ];

  system.stateVersion = "24.05";  # Ensure consistency across updates
}
