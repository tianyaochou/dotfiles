{ pkgs, ... }:
{
  services.kubo = {
    enable = true;
    dataDir = "/data/ipfs";
    enableGC = true;
  };
}