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
        devShells.${system}.default = pkgs.mkShell {
            nativeBuildInputs = [
                pkgs.rustc
                pkgs.cargo
            ];
        };
        packages.${system}.default = pkgs.rustPlatform.buildRustPackage rec {
            pname = "nixos-mastery";
            version = "0.0.0";
            cargoLock.lockFile = ./Cargo.lock;
            src = pkgs.lib.cleanSource ./.;
        };
    };
}