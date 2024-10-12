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
makepasswd
```
to create your user account password then append it to the users.user.xxx, hashedPassword = "xxxx";
