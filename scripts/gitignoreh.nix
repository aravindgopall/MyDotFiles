{ pkgs }:
with pkgs;
writeShellScriptBin "gitignoreh" ''
  ${curl}/bin/curl http://gitignore.io/api/haskell > .gitignore
''

