{ stdenv, python3, }: stdenv.mkDerivation {
  pname = "pytorchRocm suite";
  version = "2.2.1";
  src = stdenv.fetchurl {
    url = "https://download.pytorch.org/whl/rocm5.6/torch-2.1.1%2Brocm5.6-cp311-cp311-linux_x86_64.whl";
    hash = "142cbfae4897fd4883188db52280ac43ba256726";
  };

  buildInputs = [ python3.withPackages (ps: with ps; [ pip ]) ];
  buildPhase = "";
  installPhase = "pip install *.whl";
  checkPhase = "";
}