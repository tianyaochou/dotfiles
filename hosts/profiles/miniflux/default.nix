{ config, lib, pkgs, ... }:

{
  sops.secrets."ADMIN_USERNAME" = {
    sopsFile = ./secrets.yaml;
    restartUnits = ["miniflux.service"];
  };
  sops.secrets."ADMIN_PASSWORD" = {
    sopsFile = ./secrets.yaml;
    restartUnits = ["miniflux.service"];
  };
  sops.templates."miniflux-admin-credential" = {
    content = ''
            ADMIN_USERNAME=${config.sops.placeholder."ADMIN_USERNAME"}
            ADMIN_PASSWORD=${config.sops.placeholder."ADMIN_PASSWORD"}
            '';
  };

  services.miniflux = {
    enable = true;
    config = {
      LISTEN_ADDR = "localhost:8080";
      BASE_URL = "https://rss.mgourd.me/";
    };
    adminCredentialsFile = config.sops.templates."miniflux-admin-credential".path;
  };

  services.nginx.enable = true;
  services.nginx.virtualHosts."rss.mgourd.me" = {
    locations."/".proxyPass = "http://localhost:8080";
  };

  networking.firewall.allowedTCPPorts = [ 80 ];
}
