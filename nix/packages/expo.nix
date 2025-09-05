{ pkgs }:

{
  buildInputs = [ pkgs.nodejs pkgs.yarn ];
  buildCommand = "yarn install && yarn build";
  installCommand = ''
    mkdir -p $out/web-build
    cp -r web-build/* $out/web-build
  '';
}
