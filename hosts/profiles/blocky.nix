{pkgs, ...}:
{
  services.blocky = {
    enable = true;
    settings = {
      ports.http = 4000;
      upstreams = {
        groups = {
          default = ["https://cloudflare-dns.com/dns-query" "tcp-tls:1.1.1.1:853"];
        };
      };
      blocking.denylists = {
        ads = [
          "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/wildcard/popupads.txt"
          "https://blocklistproject.github.io/Lists/alt-version/ads-nl.txt"
        ];
      };
      prometheus = {
        enable = true;
        path = "/metrics";
      };
    };
  };

  networking.firewall.interfaces.enP3p49s0 = {
    allowedUDPPorts = [ 53 ];
  };
}
