#!/usr/bin/env bash

set -euo pipefail

# Default Variables
REPO_URL="https://github.com/dvorakman/nix-config.git"
FLAKE_REF="my-machine"  # Replace with your system's configuration name
TMP_DIR="/mnt/tmp/nix-config"
LOG_FILE="/tmp/nixos-install.log"

# Print usage information
usage() {
    echo "Usage: $0 [--repo-url URL] [--flake-ref NAME] [--log-file PATH]"
    echo "  --repo-url   URL of the config repository (default: $REPO_URL)"
    echo "  --flake-ref  Name of the configuration in the flake (default: $FLAKE_REF)"
    echo "  --log-file   Path to save installation logs (default: $LOG_FILE)"
    exit 1
}

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --repo-url) REPO_URL="$2"; shift ;;
        --flake-ref) FLAKE_REF="$2"; shift ;;
        --log-file) LOG_FILE="$2"; shift ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
    shift
done

# Logging setup
exec > >(tee -i "$LOG_FILE") 2>&1

# Helper functions
log() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1" >&2
    exit 1
}

# Step 1: Validate environment
log "Validating environment..."
if [[ "$(id -u)" -ne 0 ]]; then
    error "This script must be run as root."
fi

if ! mountpoint -q /mnt; then
    error "/mnt is not mounted. Please mount your target root filesystem to /mnt."
fi

if ! command -v nixos-install >/dev/null; then
    error "This script must be run in a live NixOS environment."
fi

log "Environment validation passed."

# Step 2: Backup existing configuration if present
if [[ -d /mnt/etc/nixos ]]; then
    BACKUP_DIR="/mnt/etc/nixos-backup-$(date +%Y%m%d%H%M%S)"
    log "Backing up existing /mnt/etc/nixos to $BACKUP_DIR..."
    mv /mnt/etc/nixos "$BACKUP_DIR"
fi

# Step 3: Clone the repository
log "Cloning repository from $REPO_URL..."
if [[ -d $TMP_DIR ]]; then
    log "Temporary directory $TMP_DIR already exists. Removing it."
    rm -rf "$TMP_DIR"
fi
git clone "$REPO_URL" "$TMP_DIR"

# Step 4: Run nixos-install with the flake
log "Installing NixOS using flake $TMP_DIR#$FLAKE_REF..."
nixos-install --flake "$TMP_DIR#$FLAKE_REF"

# Step 5: Cleanup temporary files
log "Cleaning up temporary files..."
rm -rf "$TMP_DIR"

log "Installation complete! Logs are saved at $LOG_FILE."
log "You can now reboot into your new system."
