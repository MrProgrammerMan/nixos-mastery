# Nix Mastery
This is a project used to learn about nix. I have been using nix and NixOS for a few weeks now. I've been dabbling in nixos devShells, packaging software with nix, using flakes to pin inputs, and so on. I want to combine it in a single project. Here's what I mean by that:
1. I want a rust project(like I would typically build).
2. I want a flake.nix that should include:
  - A devshell with rustc and cargo for deving.
  - A package that is the build rust project.

I then want to write another flake.nix that should be the servers(running NixOS) configuration. It will have the project installed and running.
I want CI/CD to react to release tags. Upon releases, it will push the updated project to cachix. The server will have a systemd that pulls in updates at midnight. Ideally, this will also work for updates to the server config. I will add services like postgres, which will use services-flake to run in dev with `nix run` and be defined as services.postgres.enable in the server config.
Finally, the flake should include checks that will be run in CI/CD and also on the server. If the checks fail, the system is rolled back to the previously stable version. If it succeeds, it should tag the current version as stable.

This will probably be easy and quick and simple and easy.