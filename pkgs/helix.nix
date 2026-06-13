{
  fetchzip,
  lib,
  rustPlatform,
  mdbook,
  git,
  installShellFiles,
  versionCheckHook,
  nix-update-script,
}:
rustPlatform.buildRustPackage (final: {
  pname = "helix";
  version = "master";
  outputs = [
    "out"
    "doc"
  ];

  # This release tarball includes source code for the tree-sitter grammars,
  # which is not ordinarily part of the repository.
  src = fetchGit {
    url = "https://github.com/helix-editor/helix";
    rev = "253e6195c8cae014da01abea6f741b12eeed674c";
  };

  cargoHash = "sha256-yvb2vq7rXtkQwriHHq5t1AuHEe74oJNek6ZXJgIvg4g=";

  nativeBuildInputs = [
    git
    installShellFiles
    mdbook
  ];

  env.HELIX_DEFAULT_RUNTIME = "${placeholder "out"}/lib/runtime";

  postBuild = ''
    mdbook build book -d ../book-html
  '';

  postInstall = ''
    # not needed at runtime
    rm -r runtime/grammars/sources

    mkdir -p $out/lib $doc/share/doc
    cp -r runtime $out/lib
    installShellCompletion contrib/completion/hx.{bash,fish,zsh}
    mkdir -p $out/share/{applications,icons/hicolor/256x256/apps}
    cp contrib/Helix.desktop $out/share/applications
    cp contrib/helix.png $out/share/icons/hicolor/256x256/apps
    cp -r book-html $doc/share/doc/$name
  '';

  nativeInstallCheckInputs = [
    versionCheckHook
  ];
  versionCheckProgram = "${placeholder "out"}/bin/hx";
  versionCheckProgramArg = "--version";
  doInstallCheck = true;

  passthru = {
    updateScript = nix-update-script {};
  };

  meta = {
    description = "Post-modern modal text editor";
    homepage = "https://helix-editor.com";
    changelog = "https://github.com/helix-editor/helix/blob/${final.version}/CHANGELOG.md";
    license = lib.licenses.mpl20;
    mainProgram = "hx";
    maintainers = with lib.maintainers; [
      danth
      yusdacra
      zowoq
    ];
  };
})
