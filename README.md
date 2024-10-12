# dotfiles (wip, while i struggle to install and comprehend nixos)

## Commands

### Disk Setup using Disko

```sh
cd /tmp
curl https://raw.githubusercontent.com/dvorakman/dotfiles/refs/heads/main/luks-btrfs-subvolumes.nix -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko /tmp/disk-config.nix
```

Verify with:

```sh
mount | grep /mnt
```

```sh
nixos-generate-config --no-filesystems --root /mnt
mv /tmp/disk-config.nix /mnt/etc/nixos
```
