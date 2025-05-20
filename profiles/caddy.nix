{pkgs, ...}: {
  networking.firewall.allowedTCPPorts = [80 443];

  services.caddy = {
    enable = true;
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
