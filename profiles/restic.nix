{pkgs, ...}: {
  services.restic.server = {
    enable = true;
    prometheus = true;
    extraFlags = ["--no-auth"];
    dataDir = "/data/restic";
  };
}
