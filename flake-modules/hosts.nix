{ inputs, ... }:
let
  hosts = inputs.haumea.lib.load { src = ../hosts; };
in
{
  flake.hosts = hosts;
}
