### Install NixOS

1. Boot from the NixOS installation media.
2. Follow the official [NixOS installation guide](https://nixos.org/manual/nixos/stable/#sec-installation) to install NixOS on your system.

### Open the terminal in root

```sh
sudo su
```

### Run disko to partition, format, and mount the disks

Ensure that `disk-config.nix` is correctly created and available in your working directory:

```sh
cd /tmp
curl -o disk-config.nix https://raw.githubusercontent.com/dvorakman/nix-config/refs/heads/main/disk-config.nix
nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko disk-config.nix
```

### Complete the NixOS installation

```sh
# nixos-generate-config --no-filesystems --root /mnt
# cd /mnt/etc/nixos
# i'm not sure whether to sym link the dotfiles or install them directly to the /etc/nixos directory, will fix soon.
mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos
```

### Clone the repository

```sh
# Install Git if it's not already installed
nix-env -iA nixos.git

# Clone your dotfiles repository (provided you're in the /mnt/etc/nixos directory)
git clone https://github.com/dvorakman/nix-config.git .
```

### Apply the configuration

```sh
# Apply the NixOS configuration
nixos-install --flake .#mySystem

# Reboot into your new system
reboot
```

### Set up Home Manager

After rebooting, set up Home Manager for the user:

```sh
# Apply the Home Manager configuration
home-manager switch --flake .#cardinal
```
