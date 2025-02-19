{ self, flake, deploy, ... }:
{
  hostname = "mainframe";
  address = [];
  system = "x86_64-linux";
  services = {
    minio = {
      address = "mainframe";
      port = 9001;
    };
  };
}
