{
    description = "System configs";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    };

    outputs = { self,  nixpkgs }:
    {
        nixosConfigurations = {
            nixvm = nixpkgs.lib.nixosSystem {
                modules = [ ./configuration.nix ];
            };
        };
    };
}