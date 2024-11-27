# dotfiles (wip, while i struggle to install and comprehend nixos)

I spent quite some time trying to chuck myself straight into the deep end with NixOS, and I'm still struggling to get a working system lol. I'm going to try something a lot simpler, and document my steps to install the same system I have here.

## Commands

### Run disko to partition, format and mount the disks

```sh
cd /tmp
curl https://raw.githubusercontent.com/dvorakman/nix-config/refs/heads/main/disk-config.nix -o /tmp/disk-config.nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko /tmp/disk-config.nix
```

### Complete the NixOS installation

```sh
nixos-generate-config --no-filesystems --root /mnt
mv /tmp/disk-config.nix /mnt/etc/nixos
```
