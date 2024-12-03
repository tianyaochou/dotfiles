{
  self,
  config,
  lib,
  pkgs,
  ...
}:
{
  environment = {
    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      coreutils
      git
    ];
  };

  services.openssh.enable = true;
  services.openssh.openFirewall = true;
  services.fail2ban.enable = true;
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = [ "systemd" ];
      port = 9002;
    };
  };

  nix.gc.automatic = true;
}
