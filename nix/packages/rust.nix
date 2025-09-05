{ pkgs }:

{
  buildInputs = [ pkgs.rustc pkgs.cargo ];
  buildCommand = "cargo build --release";
  installCommand = ''
    mkdir -p $out/bin
    cp target/release/my-package $out/bin
  '';
}
