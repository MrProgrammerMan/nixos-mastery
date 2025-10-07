{ self, pkgs }:
pkgs.nixosTest {
    name = "Nixos mastery service test";

    nodes = {
        server = { config, ... }: {
            imports = [ self.nixosModules.nixos-mastery ];

            services.nixos-mastery = {
                enable = true;
                port = 3000;
            };

            networking.firewall.allowedTCPPorts = [
                config.services.nixos-mastery.port
            ];
        };

        client = {...}: {};
    };

    globalTimeout = 20;

    testScript = { nodes, ... }: ''
        PORT = ${builtins.toString nodes.server.services.nixos-mastery.port}
        
        start_all()

        server.wait_for_unit("nixos-mastery.service")
        server.wait_for_open_port(${builtins.toString nodes.server.services.nixos-mastery.port})

        output = client.succeed(f"curl -s http://server:{PORT}/")
    '';
}