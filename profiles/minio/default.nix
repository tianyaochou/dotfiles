{
  config,
  lib,
  pkgs,
  ...
}: {
  sops.secrets."minio_root_user" = {
    sopsFile = ./secrets.yaml;
    restartUnits = ["minio.service"];
  };
  sops.secrets."minio_root_password" = {
    sopsFile = ./secrets.yaml;
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
    dataDir = ["/data/minio"];
  };
}
