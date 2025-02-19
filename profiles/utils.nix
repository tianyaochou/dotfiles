{ config, lib, pkgs, packages, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  # Sets nrdxp.cachix.org binary cache which just speeds up some builds

  environment = {

    # Selection of sysadmin tools that can come in handy
    systemPackages = with pkgs; [
      alejandra
      nixd
      binutils
      coreutils
      pciutils
      curl
      dnsutils
      fd
      git
      bottom
      btop
      jq
      manix
      moreutils
      nix-index
      nmap
      ripgrep
      skim
      tealdeer
      whois
      neofetch
    ] ++ (if isLinux then [
      dosfstools
      gptfdisk
      iputils
      usbutils
      utillinux
    ] else []) ++ (with packages; [
      deploy-rs
    ]);

    shellAliases =
      let
        # The `security.sudo.enable` option does not exist on darwin because
        # sudo is always available.
        ifSudo = lib.mkIf (isDarwin || config.security.sudo.enable);
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # git
        g = "git";

        # grep
        grep = "rg";
        gi = "grep -i";

        # internet ip
        # TODO: explain this hard-coded IP address
        myip = "dig +short myip.opendns.com @208.67.222.222 2>&1";

        # nix
        n = "nix";
        np = "n profile";
        ni = "np install";
        nr = "np remove";
        ns = "n search --no-update-lock-file";
        nf = "n flake";
        # FIXME: problem with nix-darwin
        nepl = "n repl '<nixpkgs>'";
        srch = "ns nixos";
        orch = "ns override";
        # FIXME: Something wrong with nix-darwin, which doesn't escape shell
        mn = ''manix "" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | sk --preview="manix '{}'" | xargs manix'';
        top = "btm";

        # sudo
        s = ifSudo "sudo -E ";
        si = ifSudo "sudo -i";
        se = ifSudo "sudoedit";

      };
  };

}
