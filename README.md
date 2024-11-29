# NixOS Configuration

## Overview

This repository contains my NixOS configuration files, managed with flakes for a fully reproducible system setup. It includes disk partitioning, system configuration, and optional Home Manager integration. This guide provides step-by-step instructions for installing NixOS using these configurations, including an automated installation script for convenience.

## Prerequisites

Before starting, ensure you have:
- A basic understanding of NixOS installation.
- Access to the NixOS installation media (ISO).
- A machine ready for NixOS installation with the desired partitioning scheme.
- Internet access to download dependencies during installation.

---

## Installation Steps

### Step 1: Boot into the NixOS Live Environment
1. Boot your system using the NixOS installation media.
2. Open a terminal and switch to the root user:
   ```bash
   sudo su
   ```

---

### Step 2: Partition, Format, and Mount Disks
1. Ensure that `disk-config.nix` is correctly created and available. Use `disko` to set up your partitions:
   ```bash
   cd /tmp
   curl -o disk-config.nix https://raw.githubusercontent.com/dvorakman/nix-config/refs/heads/main/disk-config.nix
   nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko disk-config.nix
   ```
2. Verify that your root filesystem is mounted at `/mnt`.

---

### Step 3: Automated Installation with `install.sh`
1. Download the installation script:
   ```bash
   curl -o install.sh https://raw.githubusercontent.com/dvorakman/nix-config/main/install.sh
   chmod +x install.sh
   ```

2. Run the installation script:
   ```bash
   ./install.sh --repo-url https://github.com/dvorakman/nix-config.git --flake-ref mySystem
   ```

   - The script will:
     - Clone the repository into a temporary directory.
     - Install NixOS using the specified flake configuration.
     - Backup any existing `/mnt/etc/nixos` configuration (if present).
     - Log the entire process to `/tmp/nixos-install.log`.

3. Once the installation is complete, reboot into your new system:
   ```bash
   reboot
   ```

---

## Post-Installation Workflow

### Move the Configuration Repository
(Optional) Move the repository to your home directory for easier access:
```bash
mv /mnt/tmp/nix-dotfiles ~/nix-dotfiles
```

### Update and Apply System Configurations
Use the flake to manage and rebuild your system:
```bash
sudo nixos-rebuild switch --flake ~/nix-dotfiles#mySystem
```

---

## Customising Your Configuration

Feel free to fork this repository and adapt it to your needs. Key areas to customize include:
- **`flake.nix`**: Define your own system configurations or modules.
- **`disk-config.nix`**: Adjust partitioning and formatting settings.
- **Home Manager Configurations**: Add or modify user-specific settings.

---

## Troubleshooting

### Disk Partitioning
- If `disko` fails, ensure your disk identifiers (e.g., `/dev/sdX`) match those defined in `disk-config.nix`.

### Installation Script Errors
- If the `install.sh` script reports "no such file or directory," check if the file was downloaded correctly.
- If `nixos-install` fails, review the logs saved in `/tmp/nixos-install.log` for details.

### Network Issues
- Ensure your system has internet access during installation. Use `ping nixos.org` to test connectivity.
