{
  config,
  lib,
  pkgs,
  ...
}: {
  services.maddy = {
    enable = true;
  };
}
