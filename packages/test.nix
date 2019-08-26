{pkgs }:
with pkgs;
let

  # Please keep the version x.y.0.z and do not update to x.y.76.z because the
  # source of the latter disappears much faster.
  version = "12.0.0";

  src = ./Linux_THOPTV_v12_AMD64.deb;

in stdenv.mkDerivation {
  name = "thop-${version}";

  system = "x86_64-linux";

  inherit src;

  # Required for compilation
  nativeBuildInputs = [
    autoPatchelfHook # Automatically setup the loader, and do the magic
    dpkg
  ];

  # Required at running time
  buildInputs = [
    glibc
    gcc-unwrapped
  ];

  unpackPhase = "true";

  # Extract and copy executable in $out/bin
  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    rm -rf $out/opt
  '';

  meta = with stdenv.lib; {
    description = "THOPTV";
    homepage = https://www.wolfram.com/wolframscript/;
    license = licenses.mit;
    maintainers = with stdenv.lib.maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}
