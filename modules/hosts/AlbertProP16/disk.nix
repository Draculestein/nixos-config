{ den, inputs, ... }:
{
  den.aspects.AlbertProP16.nixos = {
    imports = [
      inputs.disko.nixosModules.default
    ];

    disko.devices = {
      disk.main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            # Boot partition
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };

            # LVM Partition
            root = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              };
            };

          };
        };
      };

      disk."home" = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            "btrfs" = {
              start = "4MiB";
              end = "100%";
              content = {
                type = "btrfs";
                subvolumes = {
                  "@home" = {
                    mountpoint = "/home";
                  };
                };
              };
            };
          };
        };
      };

      # Volume group config
      lvm_vg = {
        root_vg = {
          type = "lvm_vg";
          lvs = {
            # Swap volume
            swap = {
              size = "32G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };

            # BTRFS volume
            root = {
              size = "100%FREE";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                  };
                  "@nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "@snapshots" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/snapshots";
                  };
                  "@log" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var/log";
                  };
                  "@lib" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var/lib";
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
