{ lib, config, pkgs, ... }:{
  environment.shellAliases."reboot-windows" = lib.mkIf config.boot.loader.systemd-boot.enable "sudo systemctl reboot --boot-loader-entry=auto-windows";
}