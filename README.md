### Install NixOS

1. Boot from the NixOS installation media.
2. Follow the official [NixOS installation guide](https://nixos.org/manual/nixos/stable/#sec-installation) to install NixOS on your system.

### Clone the repository

After installing NixOS and rebooting into your new system, open a terminal and run the following commands:

```sh
# Install Git if it's not already installed
nix-env -iA nixos.git

# Clone your dotfiles repository
git clone https://github.com/dvorakman/nix-config.git ~/.config/nix-config
cd ~/.config/nix-config
```

### Run disko to partition, format and mount the disks

```sh
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko disk-config.nix
```

### Complete the NixOS installation

```sh
nixos-generate-config --no-filesystems --root /mnt
mv /tmp/disk-config.nix /mnt/etc/nixos
```

### Apply the configuration

```sh
# Move to the configuration directory
cd /mnt/etc/nixos

# Apply the NixOS configuration
nixos-install --flake .#mySystem

# Reboot into your new system
reboot
```

### Set up Home Manager

After rebooting, set up Home Manager for the user:

```sh
# Switch to the user's home directory
cd /etc/nixos

# Apply the Home Manager configuration
home-manager switch --flake .#cardinal
```

Your system should now be configured with the dotfiles from this repository.
