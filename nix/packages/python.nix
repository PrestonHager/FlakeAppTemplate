{ pkgs }:

{
  buildInputs = [ pkgs.python3 ];
  buildCommand = ""; # No build command needed
  installCommand = ''
    mkdir -p $out/bin
    cp my-package.py $out/bin/my-package
    chmod +x $out/bin/my-package
  '';
}
