{
    description = "A project to practice building and deploying with nixos";
    
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    };

    outputs = { self, nixpkgs, ... }:
    let
        forAllSystems = nixpkgs.lib.genAttrs ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
        nixosMasteryOverlay = final: prev: {
            nixos-mastery = final.callPackage ./nixos-mastery.nix { pkgs = final; };
        };
    in {
        devShells = forAllSystems (
            system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                };
            in {
                default = pkgs.callPackage ./shell.nix { inherit pkgs; };
            }
        );

        packages = forAllSystems (
            system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                };
            in {
                default = pkgs.callPackage ./nixos-mastery.nix { inherit pkgs; };
            }
        );
        
        nixosModules.nixos-mastery = import ./nixos-mastery-module.nix;

        checks = forAllSystems (
            system:
            let
                pkgs = import nixpkgs {
                    inherit system;
                    overlays = [ nixosMasteryOverlay ];
                };
            in {
                nixos-mastery = pkgs.callPackage ./test.nix { inherit self pkgs; };
            }
        );
    };
}