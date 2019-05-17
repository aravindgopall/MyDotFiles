{pkgs, easy-purs, lib}:

let
   dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  patchelf = libPath: if pkgs.stdenv.isDarwin
    then ""
    else ''
          chmod u+w $PURS
          patchelf --interpreter ${dynamic-linker} --set-rpath ${libPath} $PURS
          chmod u-w $PURS
        '';
in
with pkgs;
easy-purs.purs.overrideAttrs(oldattrs: {
  name = "old-purs";
  version = "v0.11.7";
  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.11.7/macos.tar.gz";
      sha256 = "1kl8zsrhj32lcdsgqsz4fqsr2f40xlrc5c5hi6na5agq908s3jnq";
    }
    else pkgs.fetchurl {
      url = "https://github.com/purescript/purescript/releases/download/v0.11.7/linux64.tar.gz";
      sha256 = "1ppxic1qfcf1j0ldihascm4q03a72vs26iv545gzg1cl1qj9d2zx";
    };
    installPhase = ''
      mkdir -p $out/bin
      PURS="$out/bin/old-purs"
      install -D -m555 -T purs $PURS
      ${patchelf oldattrs.libPath}
      mkdir -p $out/etc/bash_completion.d/
      #$PURS --bash-completion-script $PURS > $out/etc/bash_completion.d/purs-completion.bash
      '';

    #installPhase = lib.replaceStrings ["$PURS --bash" "bin"] ["# $PURS --bash" "oldbin"] easy-purs.purs.installPhase;
  })
