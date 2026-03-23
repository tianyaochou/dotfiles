{pkgs, ...}: {
  services.authelia.instances = {
    main = {
      enable = true;
      settings = {
        telemetry.metrics = {
          enabled = true;
          address = "tcp://0.0.0.0:9959";
        };
      };
      secrets = {
        jwtSecretFile = "/var/lib/authelia/jwtSecret";
        storageEncryptionKeyFile = "/var/lib/authelia/storageKey";
      };
    };
  };

  services.caddy = {
    virtualHosts = {
      authelia = {
        hostName = "auth.mgourd.me";
        extraConfig = ''
          reverse_proxy :9091
        '';
      };
    };
  };
}
