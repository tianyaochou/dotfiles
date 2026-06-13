{
  pkgs,
  config,
  ...
}: {
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  sops.secrets."cloudflare_token" = {
    sopsFile = ./secrets.yaml;
    restartUnits = ["caddy.service"];
  };

  sops.templates."caddy-env" = {
    content = ''
      CLOUDFLARE_API_TOKEN=${config.sops.placeholder."cloudflare_token"}
    '';
    owner = "caddy";
  };

  services.caddy = {
    enable = true;
    package =
      (pkgs.caddy.withPlugins {
        plugins = ["github.com/caddy-dns/cloudflare@v0.2.3"];
        hash = "sha256-mmkziFzEMBcdnCWCRiT3UyWPNbINbpd3KUJ0NMW632w=";
      }).overrideAttrs
      (old: {
        # Patch token validation regex to accept cfut_/cfat_ tokens (>50 chars).
        # Upstream fix: github.com/caddy-dns/cloudflare/pull/123
        postPatch =
          (old.postPatch or "")
          + ''
            sed -i 's/{35,50}/{35,256}/' vendor/github.com/caddy-dns/cloudflare/cloudflare.go
          '';
      });
    environmentFile = config.sops.templates."caddy-env".path;
    globalConfig = ''
      acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
    '';
    virtualHosts = {
      rss = {
        hostName = "rss.mgourd.me";
        extraConfig = ''
          reverse_proxy :8080
        '';
      };
    };
  };
}
