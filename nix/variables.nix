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

  # The build inputs for the package.
  # This should be a list of packages that are needed to build the package.
  # For example, for a Rust project, you would use: [ pkgs.rustc pkgs.cargo ]
  # For a Python project, you would use: [ pkgs.python3 ]
  buildInputs = [ pkgs.gcc ];

  # The build command for the package.
  # This command will be executed in the source directory to build the package.
  # The output of the build should be placed in the $out directory.
  # For example, for a Rust project, you would use: ''cargo build --release''
  # For a Python project, you can leave this empty if you are not building anything.
  buildCommand = ''
    make
  '';

  # The install command for the package.
  # This command will be executed to install the package.
  # For example, for a Rust project, you would use:
  # ''
  #   mkdir -p $out/bin
  #   cp target/release/my-package $out/bin
  # ''
  # For a Python project, you would use:
  # ''
  #   mkdir -p $out/bin
  #   cp my-package.py $out/bin/my-package
  #   chmod +x $out/bin/my-package
  # ''
  installCommand = ''
    mkdir -p $out/bin
    cp my-package $out/bin
  '';
}
