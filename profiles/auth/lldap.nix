{pkgs, ...}: {
  services.lldap = {
    enable = true;
    settings = {
    };
  };
}
