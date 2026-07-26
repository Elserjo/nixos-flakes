{ lib, self, ... }:

let 
    entries = builtins.attrNames (builtins.readDir ./.);
    configs = builtins.filter (dir: builtins.pathExists (./. + "/${dir}/configuration.nix")) entries;
    homeConfig =  {
        home-manager.users."serg" = {
            home.homeDirectory = "/Users/serg";
            home.stateVersion = "26.05";
            imports = [
            ../../home-manager/programs/git.nix
            ../../home-manager/programs/vim.nix
            ../../home-manager/programs/htop.nix
            ../../home-manager/programs/zsh.nix
            ];
        };
        home-manager.useGlobalPkgs = true;
        home-manager.extraSpecialArgs = {
            inherit (self) inputs;
        };
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "bak";
    };
in
{
    flake.darwinConfigurations = lib.listToAttrs (
        builtins.map (
            name:
            lib.nameValuePair name (
                self.inputs.nix-darwin.lib.darwinSystem {
                    specialArgs = { 
                        inherit (self) inputs;
                        self = {
                            darwinModules = self.darwinModules;
                        };
                    };

                    modules = [
                        self.inputs.home-manager.darwinModules.home-manager
                        homeConfig
                        { nixpkgs.hostPlatform = "aarch64-darwin"; }
                        { home-manager.users.serg.home.homeDirectory = 
                            self.inputs.nixpkgs.lib.mkForce "/Users/serg"; }
                        (./. + "/${name}/configuration.nix")
                    ];
                }
            )
        ) configs
    );
}
