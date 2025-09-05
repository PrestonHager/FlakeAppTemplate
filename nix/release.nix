{ pkgs, pkg }:

pkgs.runCommand "${pkg.name}-${pkg.version}.tar.gz" { buildInputs = [ pkgs.gnutar ]; } ''
  tar -czf $out ${pkg}
''