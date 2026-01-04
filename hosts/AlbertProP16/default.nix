{ inputs, lib, ... }: {
  flake.nixosConfigurations = {
    AlbertProP16 = inputs.nixpkgs-unstable.lib.nixosSystem {
      modules = [
        { nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; }
        inputs.self.modules.nixos.AlbertProP16
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.albertjul = import ../../users/albertjul/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
  };
}
