{stdenv, fetchFromGitHub, fetchurl, perlPackages, makeWrapper}:

let
  TermExtendedColor = perlPackages.buildPerlPackage rec {
    name = "Term-ExtendedColor-0.504";
    src = fetchurl {
      url = "mirror://cpan/authors/id/W/WO/WOLDRICH/${name}.tar.gz";
      sha256 = "8965f8f032a27df755b92b27a07901b0dbb2ee0178c0f6fa38c7f5c4d3c00380";
    };
    meta = {
      homepage = http://japh.se/;
      description = "Color screen output using extended escape sequences";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

  FileLsColor = perlPackages.buildPerlPackage rec {
    name = "File-LsColor-0.512";
    src = fetchurl {
      url = "mirror://cpan/authors/id/W/WO/WOLDRICH/${name}.tar.gz";
      sha256 = "d1290df4981c557618adb0211ca24f8c53f898405c149ced96f3b8dc496a85d8";
    };
    propagatedBuildInputs = [ TermExtendedColor ];
    meta = {
      homepage = http://japh.se/dev/file-lscolor/;
      description = "Colorize input filenames like ls(1)";
      license = with stdenv.lib.licenses; [ artistic1 gpl1Plus ];
    };
  };

in
stdenv.mkDerivation rec {
  name = "ls++-${version}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "trapd00r";
    repo = "ls--";
    rev = "8d61463d966c1b504f5cae25163d676cc52540ee";
    sha256 = "0pzs355w7p13732f08al5y1g4mqfrd13dp5fiag1mfiias0qkpzg";
  };


  buildInputs = with perlPackages; [
    makeWrapper perl CPANPLUS TermReadKey TermUI
  ] ++ [ TermExtendedColor FileLsColor];

  installPhase = ''
    mkdir -p $out/bin

    cp ls++ $out/bin
    cp ls++.conf $out/bin
    patchShebangs $out/bin/ls++

    wrapProgram $out/bin/ls++ --set PERL5LIB $PERL5LIB

  '';
}
