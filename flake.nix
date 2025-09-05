{
  description = "A highly opinionated framework for creating apps";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      # Get the system from the nixpkgs.
      system = nixpkgs.legacyPackages.x86_64-linux;

      # Import the variables from the variables.nix file.
      vars = (import ./nix/variables.nix) { pkgs = system; };

      # Import the package-specific attributes.
      packageAttrs = (import ./nix/packages/${vars.packageType}.nix) { pkgs = system; };

      # Create the package using the variables.
      pkg = system.stdenv.mkDerivation (vars // packageAttrs);
    in
    {
      # The default package for the flake.
      # This can be built with `nix build`.
      defaultPackage.x86_64-linux = pkg;

      # The development shell for the flake.
      # This can be entered with `nix develop`.
      devShell.x86_64-linux = system.mkShell {
        buildInputs = packageAttrs.buildInputs;
      };

      # The overlay for the flake.
      # This can be used in nixos or home-manager to install the package.
      overlay.x86_64-linux = final: prev: {
        ${vars.packageName} = pkg;
      };

      # The release for the flake.
      # This can be used to create a release of the package.
      release.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.callPackage ./nix/release.nix {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        inherit pkg;
      };
    };
}
