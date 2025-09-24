{super, ...}: {
  config,
  pkgs,
  profiles,
  users,
  ...
}: let
  hostName = super.meta.hostname;
in {
  imports = with profiles; [darwin nix utils sops];
  programs.fish.enable = true;
  # environment.shells = with pkgs; [ fish ];

  system.primaryUser = "tianyaochou";

  # Homebrew
  # system.activationScripts.homebrew.enable = false;
  homebrew.global.brewfile = true;
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "uninstall";
  homebrew.brews = [
    "lux"
    #    "displayplacer"
  ];
  homebrew.casks = [
    #    "appcleaner"
    "pearcleaner"
    "orion"
    "blockblock"
    "iina"
    "keka"
    "bettertouchtool"
    "thingsmacsandboxhelper"
    "shottr"
    "obsidian"
    "notion"
    "pdf-expert"
    "skim"
    #    "dash"
    #    "vmware-fusion"
    "transmit"
    "iterm2"
    "balenaetcher"
    "pika"
    "monitorcontrol"

    "steam"

    "vial"
    #    "soundsource"
    #    "macfuse"

    "blender"
    #    "kicad"
    #    "freecad"
    #    "racket"
    #    "zed"

    #    "calibre"
    #    "discord"
    #    "google-chrome"
  ];

  # HACK: This is sloooooooooooowwwww
  # homebrew.masApps = {
  #   "1Password 7" = 1333542190;
  #   Keynote = 409183694;
  #   Numbers = 409203825;
  #   Pages = 409201541;
  #   "Pixelmator Pro" = 1289583905;
  #   RunCat = 1429033973;
  #   StopTheMadness = 1376402589;
  #   OneDrive = 823766827;
  # };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
