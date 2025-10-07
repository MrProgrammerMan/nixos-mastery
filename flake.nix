{
    description = "A project to practice building and deploying with nixos";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    };

    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        devShells.${system}.default = pkgs.callPackage ./shell.nix { inherit pkgs; };
        packages.${system}.default = pkgs.callPackage ./nixos-mastery.nix { inherit pkgs; };
    };
}