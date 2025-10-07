{ pkgs }:
pkgs.rustPlatform.buildRustPackage rec {
    pname = "nixos-mastery";
    version = "0.0.0";
    cargoLock.lockFile = ./Cargo.lock;
    src = pkgs.lib.cleanSource ./.;
}