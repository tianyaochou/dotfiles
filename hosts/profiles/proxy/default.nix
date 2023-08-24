{ config, lib, pkgs, ... }:
{
  sops.secrets."config.yaml" = {
    sopsFile = ./config.yaml;
    type = "binary";
    restartUnits = [ "clash-meta.service" ];
  };

  environment.systemPackages = [ pkgs.clash-meta ];

  systemd.user.services.clash-meta = {
    script = ''
      ${pkgs.clash-meta}/bin/clash-meta -f ${config.sops.secrets."config.yaml".path}
    '';
  };

  networking.proxy = {
    default = "http://127.0.0.1:7890";
  };
}
