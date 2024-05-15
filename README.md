# NixOS Config

## Setup

### Disk Install
1. Clone `disk_config.nix` to `/tmp`
2. Run: 
    ```
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disk_config.nix --arg device '"/dev/vda"'
    ```
