{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  ...
} : {
  disko.devices = {

    disk.main = {

      type = "disk";
      inherit device;

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
      # Volume group config
      lvm_vg = {

        root_vg = {

          type = "lvm_vg";
          lvs = {

            # Swap volume
            swap = {

              size = "4G";
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

                  "@home" = {
                    mountpoint = "/home";
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
}