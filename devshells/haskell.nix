{ inputs, ... }: {
  perSystem = { ... }:{
    devenv.shells.haskell = {
      languages.haskell.enable = true;
    };
  };
}