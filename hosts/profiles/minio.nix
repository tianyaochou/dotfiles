{ config, lib, pkgs, ... }:

{
  sops.defaultSopsFile = ../../secrets/secrets.yaml;

  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  sops.secrets."minio_root_user" = {
    restartUnits = ["minio.service"];
  };
  sops.secrets."minio_root_password" = {
    restartUnits = ["minio.service"];
  };

  sops.templates."minio-root-credentials" = {
    content = ''
            MINIO_ROOT_USER=${config.sops.placeholder."minio_root_user"}
            MINIO_ROOT_PASSWORD=${config.sops.placeholder."minio_root_password"}
            '';
    owner = "minio";
  };

  services.minio = {
    enable = true;
    rootCredentialsFile = config.sops.templates."minio-root-credentials".path;
  };
}
