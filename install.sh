#!/bin/bash

# Prompt for password
read -sp "Enter password: " password
echo
read -sp "Confirm password: " password_confirm
echo

if [ "$password" != "$password_confirm" ]; then
  echo "Passwords do not match."
  exit 1
fi

# Hash the password
hashed_password=$(mkpasswd -m sha-512 "$password")

# Update configuration.nix
sed -i "s|hashedPassword = \".*\";|hashedPassword = \"$hashed_password\";|" configuration.nix

echo "Password has been hashed and updated in configuration.nix"
