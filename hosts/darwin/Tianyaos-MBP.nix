{ config, pkgs, ... }:
let 
  hostName = "Tianyaos-MBP";
in
{
  programs.fish.enable = true;
  # environment.shells = with pkgs; [ fish ];

  # Homebrew
  # system.activationScripts.homebrew.enable = false;
  homebrew.global.brewfile = true;
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "uninstall";
  homebrew.taps = [ "homebrew/cask" "homebrew/cask-drivers" ];
  homebrew.brews = [
    "lux"
    "gmp"
    "ghcup"
  ];
  homebrew.casks = [
    "steam"
    "appcleaner"
    "blockblock"
    "iina"
    "keka"
    "raycast"
    "obsidian"
    "logseq"
    "busycal"
    "pdf-expert"
    "skim"
    "racket"
    "dash"
    "vmware-fusion"
    "zoom"
    "zotero"
    "motrix"
    "cyberduck"
    "keybase"
    "quarto"
    "anki"

    "blackhole-16ch"
    "soundsource"
    "macfuse"

    "clashx"
    "calibre"
    "netnewswire"
    "discord"
    "drawio"
    "fujifilm-x-raw-studio"
    "google-chrome"
    "macdown"
    "obsidian"
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
  system.stateVersion = 4;
}
