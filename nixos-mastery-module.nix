{ config, pkgs, lib, ... }:
let
    cfg = config.services.nixos-mastery;
in {
    options.services.nixos-mastery = {
        enable = lib.mkEnableOption "nixos-mastery";
        port = lib.mkOption {
            type = lib.types.port;
            default = 3000;
            description = "Port to listen on";
        };
    };

    config = lib.mkIf cfg.enable {
        systemd.services.nixos-mastery = {
            description = "Nixos mastery example daemon";
            serviceConfig = {
                ExecStart = "${pkgs.nixos-mastery}/bin/nixos-mastery --port=${builtins.toString cfg.port}";
            };
            wantedBy = [ "multi-user.target" ];
        };
    };
}