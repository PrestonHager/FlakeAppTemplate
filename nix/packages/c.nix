{ pkgs }:

{
  buildInputs = [ pkgs.gcc pkgs.gnumake ];
  buildCommand = "make";
  installCommand = ''
    mkdir -p $out/bin
    cp my-package $out/bin
  '';
}
