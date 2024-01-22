{ pkgs, ... }: {
  services.wordpress = {
    webserver = "caddy";
    sites."xueting.li" = {
      virtualHost = {
        hostName = "xueting.li";
      };
      settings = {
        WP_SITEURL = "http://xueting.li";
        WP_HOME = "https://xueting.li";
      };
      extraConfig = ''
      '';
    };
  };
}