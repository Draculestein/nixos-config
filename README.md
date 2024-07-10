# Draculestein's NixOS Config

## What is this?

This is my NixOS configuration which I personally use as a daily driver. Currently, it only contains configuration for 1 system, FlowX13 (ASUS ROG Flow X13 GV301QE). Features of this configuration:

- Flake-based, allowing for easy version locking of packages.
- Atomic, each application has its own corresponding file and config.
- (In Progress) Secret management using sops-nix. 

## Installation

### Requirements
- NixOS ISO (this config uses 23.11)
- Thumb drive (4GB min.), ignore if installed in VM.

### Setup Disk
1. Boot into the ISO.
2. Open a shell and run this:
    ```
    nix-shell -p git --experimental-features 'nix-command flakes'
    ```
3. After entering the nix-shell, clone this repo.
    ```
    git clone https://github.com/Draculestein/nixos-config
    ```
4. Navigate into the repo and open `disk_config.nix` to adjust file system (e.g. change the size of the swap partition, change the filesystem).
5. Run this command. Replace `/path/to/disk_config.nix` to the absolute path of your `disk_config.nix`
    ```
    sudo nix run github:nix-community/disko -- --mode disko /path/to/disk_config.nix --arg device '"/dev/vda"'
    ```
6. Check if the command run successfully by running:
    ```
    mount | grep /mnt
    ```
    Check the error log if the result does not look right.
7. Run this command to generate `hardware-configuration.nix`:
    ```
    nixos-generate-config --no-filesystems --root /mnt > /path/to/hardware-configuration.nix
    ```
8. Run this command to build the system:
    ```
    sudo nixos-rebuild switch --flake .#AlbertFlowX13
    ```

