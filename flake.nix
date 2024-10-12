{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, disko, nixpkgs }: {
    nixosConfigurations.mymachine = nixpkgs.legacyPackages.x86_64-linux.nixos [
      ./configuration.nix
      disko.nixosModules.disko
      {
	disko.devices = {
	    disk = {
	      main = {
		type = "disk";
		device = "/dev/vdb";
		content = {
		  type = "gpt";
		  partitions = {
		    ESP = {
		      size = "512M";
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
		            "/root" = {
		              mountpoint = "/";
		              mountOptions = [ "compress=zstd" "noatime" ];
		            };
		            "/home" = {
		              mountpoint = "/home";
		              mountOptions = [ "compress=zstd" "noatime" ];
		            };
		            "/nix" = {
		              mountpoint = "/nix";
		              mountOptions = [ "compress=zstd" "noatime" ];
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
    ];
  };
}
