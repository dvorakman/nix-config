{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "@root" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" "ssd" "space_cache=v2" "autodefrag" "discard=async" ];
                    };
                    "@persist" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" "ssd" "space_cache=v2" "autodefrag" "discard=async" ];
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" "ssd" "space_cache=v2" "autodefrag" "discard=async" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
