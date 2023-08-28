{ config, lib, pkgs, ... }:
{
  sops.secrets."config.yaml" = {
    sopsFile = ./config.yaml;
    format = "binary";
    restartUnits = [ "clash-meta.service" ];
  };

  environment.systemPackages = [ pkgs.clash-meta ];

  systemd.services.clash-meta = {
    script = ''
      ${pkgs.clash-meta}/bin/clash-meta -f ${config.sops.secrets."config.yaml".path} -d /var/lib/clash
    '';
    wantedBy = ["multi-user.target"];
    after = [ "network-online.target" ];
  };

  system.activationScripts.mkClashDir = lib.stringAfter ["var"] ''
    mkdir -p /var/lib/clash
    ln -s ${pkgs.clash-geoip}/etc/clash/Country.mmdb /var/lib/clash/country.mmdb
  '';

  networking.proxy = {
    default = "http://127.0.0.1:7890";
  };
}
