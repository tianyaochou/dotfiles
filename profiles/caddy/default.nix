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
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.3"];
      hash = "sha256-mmkziFzEMBcdnCWCRiT3UyWPNbINbpd3KUJ0NMW632w=";
    };
    environmentFile = config.sops.templates."caddy-env".path;
    globalConfig = ''
      # acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
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
