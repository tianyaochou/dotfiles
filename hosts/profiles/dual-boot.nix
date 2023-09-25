{ lib, config, ... }:{
  environment.shellAliases."reboot-windows" = lib.mkIf config.boot.loader.systemd-boot.enable "systemctl reboot --boot-loader-entry=auto-windows";
}