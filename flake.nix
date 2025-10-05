{
    description = "A project to practice building and deploying with nixos";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    }

    outputs = { self, pkgs,  }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.${system}.legacyPackages;
    in {
        devShells.${system}.default = pkgs.mkShell {
            nativeBuildInputs = [
                rustc
                cargo
            ];
        };
        packages.${system}.default = pkgs.rustPlatform.buildRustPackage rec {
            pname = "nixos-mastery";
            version = "0.0.0";
            cargoLock.lockFile = ./Cargo.lock;
            src = pkgs.lib.cleanSource ./.;
        }
    }
}