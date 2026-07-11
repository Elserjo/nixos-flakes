{ inputs, pkgs, lib, self, ... }:

let 
    homeConfig =  {
        home-manager.users."serg" = {
            home.homeDirectory = "/Users/serg";
            home.stateVersion = "26.05";
            imports = [
            ../../home-manager/programs/git.nix
            ../../home-manager/programs/vim.nix
            ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "bak";
    };
in
{
    flake = {
        darwinConfigurations."Air-Sergej" = 
            inputs.nix-darwin.lib.darwinSystem {
                specialArgs = { inherit inputs; };
                modules = [
                    inputs.home-manager.darwinModules.home-manager
                    homeConfig
                    { nixpkgs.hostPlatform = "aarch64-darwin"; }
                    { home-manager.users.serg.home.homeDirectory = 
                        self.inputs.nixpkgs.lib.mkForce "/Users/serg"; }

                    ./air-sergej/configuration.nix
                ];
            };
        };
}

