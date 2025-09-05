{ pkgs }:

# This file contains all the variables that need to be modified for a new project.
{
  # The name of the package.
  # This will be used in the flake's outputs and in the overlay.
  packageName = "my-package";

  # The version of the package.
  version = "0.1.0";

  # The source directory of the package.
  # This should be the directory containing the source code.
  src = ../src;

  # The type of the package to build.
  # This should be the name of a file in the nix/packages directory (without the .nix extension).
  # For example, to build a C project, you would use: "c"
  # For a Rust project, you would use: "rust"
  # For a Python project, you would use: "python"
  # For an Expo project, you would use: "expo"
  packageType = "c";
}