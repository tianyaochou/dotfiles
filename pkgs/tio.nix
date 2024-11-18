{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  glib,
  inih,
  lua,
  bash-completion,
  darwin,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "tio";
  version = "3.6";

  src = fetchFromGitHub {
    owner = "tio";
    repo = "tio";
    rev = "ef12ed62df6bc5d7a2571a7a9f31be748af68cf3";
    hash = "sha256-67abZRtadxpkOAAYiWVYVeYb68jMhwMZm2pTkh41JaU=";
  };

  strictDeps = true;

  buildInputs = [
    inih
    lua
    glib
  ] ++ lib.optionals (stdenv.hostPlatform.isDarwin) [ darwin.apple_sdk.frameworks.IOKit ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    bash-completion
  ];
})
