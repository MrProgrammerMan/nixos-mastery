{ pkgs }:
pkgs.mkShell {
    nativeBuildInputs = [
        pkgs.rustc
        pkgs.cargo
    ];
}