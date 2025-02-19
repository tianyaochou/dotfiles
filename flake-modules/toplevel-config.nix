{
  config,
  self,
  inputs,
  lib,
  withSystem,
  getSystem,
  ...
}: let
  inherit (builtins) mapAttrs concatMap listToAttrs concatLists elemAt attrNames filter;
  inherit (lib) mapAttrsToList filterAttrs;
  fst = l: elemAt l 0;
  snd = l: elemAt l 1;
  tuple = l: r: [l r];
  isLinux = system: builtins.isList (builtins.match ".*linux" system);
  mkHostConfiguration = hostname: body: mods: let
    meta = body.meta;
  in
    withSystem body.meta.system (
      {
        system,
        self',
        ...
      }: let
        mkSystem =
          if isLinux system
          then inputs.nixpkgs.lib.nixosSystem
          else inputs.nix-darwin.lib.darwinSystem;
        sops =
          if isLinux system
          then [inputs.sops-nix.nixosModules.sops]
          else [];
      in
        mkSystem {
          system = meta.system;
          specialArgs = {
            profiles = config.flake.profiles;
            users = config.flake.users;
            inputs = inputs;
            packages = self'.packages;
          };
          modules =
            sops
            ++ [
              # nix-path-config
              body.config
            ]
            ++ mods;
        }
    );
  mkHomeConfiguration = username: hostname: mods: let
    meta = hosts.${hostname}.meta;
    system = meta.system;
    sysconfig = getSystem system;
  in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs =
        if (isLinux system)
        then inputs.nixpkgs.legacyPackages.${system}
        else inputs.nixpkgs-darwin.legacyPackages.${system};
      modules =
        [
          {
            home.username = username;
            home.homeDirectory =
              if isLinux system
              then "/home/${username}"
              else "/Users/${username}";
            programs.home-manager.enable = true;
            nixpkgs.config.allowUnfree = true;
          }
        ]
        ++ mods;
      extraSpecialArgs = {
        user = users.${username}.default;
        profiles = home.profiles;
        packages = sysconfig.packages;
      };
    };
  mkDeploy = hostname: host: host-users: let
    meta = host.meta;
    system = meta.system;
    activates = inputs.deploy-rs.lib.${system}.activate;
  in {
    hostname = hostname;
    profiles =
      {
        system = {
          user = "root";
          interactiveSudo = true;
          path =
            if isLinux system
            then activates.nixos (config.flake).nixosConfigurations.${hostname}
            else activates.darwin (config.flake).darwinConfigurations.${hostname};
        };
      }
      // listToAttrs
      (map
        (username: let
          profileName = "${username}@${hostname}";
        in {
          name = profileName;
          value = {
            path = activates.home-manager (config.flake).homeConfigurations.${profileName};
          };
        })
        (filter (name: users.${name}.default.hosts.${hostname}.homeProfiles != []) host-users));
  };
  hosts = config.flake.hosts;
  home = config.flake.home;
  users = config.flake.users;
  nixosHosts = filterAttrs (name: value: isLinux value.meta.system) hosts;
  darwinHosts = filterAttrs (name: value: !(isLinux value.meta.system)) hosts;
  user-hosts = mapAttrs (username: value: value.default.hosts) users;
  host-users = let
    user-host-list = concatLists (mapAttrsToList (name: val: map (host: tuple name host) (attrNames val)) user-hosts);
  in
    host: map (elem: fst elem) (filter (elem: host == snd elem) user-host-list);
in {
  flake = {
    nixosConfigurations =
      mapAttrs
      (hostname: host: mkHostConfiguration hostname host (concatMap (username: users.${username}.default.hosts.${hostname}.profiles) (host-users hostname)))
      nixosHosts;

    darwinConfigurations =
      mapAttrs
      (hostname: host: mkHostConfiguration hostname host (concatMap (username: users.${username}.default.hosts.${hostname}.profiles) (host-users hostname)))
      darwinHosts;

    homeConfigurations =
      listToAttrs
      (concatLists
        (mapAttrsToList
          (username: user:
            mapAttrsToList
            (hostname: host: {
              name = username + "@" + hostname;
              value = mkHomeConfiguration username hostname user.default.hosts.${hostname}.homeProfiles;
            })
            user.default.hosts)
          users));

    deploy = {
      remoteBuild = true;
      sshUser = "tianyaochou";
      nodes =
        mapAttrs
        (hostname: host: mkDeploy hostname host (host-users hostname))
        hosts;
    };
  };
}
