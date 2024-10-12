# dotfiles (wip, while i struggle to install and comprehend nixos)

## Commands

```sh
nixos-generate-config --root /tmp/config --no-filesystems
```

```sh
sudo nix run 'github:nix-community/disko/latest#disko-install' --extra-experimental-features nix-command --extra-experimental-features flakes -- --write-efi-boot-entries --flake '/tmp/config/etc/nixos#mymachine' --disk main /dev/nvme0n1
```
