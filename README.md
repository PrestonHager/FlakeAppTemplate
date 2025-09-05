# AppFlake Template

This is a template repository for creating applications using Nix Flakes.

## Usage

1.  **Copy this repository.**
2.  **Modify `nix/variables.nix`** to set your package's name, version, and type.
3.  **Write your code** in the `src` directory.

## Building

To build the package, run:

```
nix build
```

This will create a `result` symlink to the built package.

## Development

To enter a development shell with all the specified `buildInputs`, run:

```
nix develop
```

Inside the shell, you can use the `buildInputs` to build your project.

## Running

To run the package, run:

```
nix run
```

## Releasing

To create a release of the package, run:

```
nix build .#release.x86_64-linux
```

This will create a tarball of the package in the `result` directory.

## Package Types

This template uses a modular system for defining package types. The package type is selected in the `nix/variables.nix` file by setting the `packageType` variable.

The available package types are defined as `.nix` files in the `nix/packages` directory. Each file defines the `buildInputs`, `buildCommand`, and `installCommand` for a specific language or framework.

You can easily add your own package types by creating a new `.nix` file in the `nix/packages` directory.

### Included Package Types

*   **c**: For C projects.
*   **rust**: For Rust projects.
*   **python**: For Python projects.
*   **expo**: For Expo (React Native) projects.

### Adding a New App Type

To add a new app type, you need to create a new `.nix` file in the `nix/packages` directory. This file should return an attribute set with the `buildInputs`, `buildCommand`, and `installCommand` for your language or framework.

For example, to add a new app type for Go, you would create a new file called `nix/packages/go.nix` with the following content:

```nix
{ pkgs }:

{
  buildInputs = [ pkgs.go ];
  buildCommand = "go build -o my-go-app";
  installCommand = ''
    mkdir -p $out/bin
    cp my-go-app $out/bin
  '';
}
```

Then, in your `nix/variables.nix` file, you would set the `packageType` to `"go"`.

For more details on how to use each package type, please refer to the corresponding file in the `nix/packages` directory.

## Overlay

This flake provides an overlay that can be used to install the package on NixOS or with Home Manager.

### NixOS

In your `configuration.nix`:

```nix
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/<owner>/<repo>/archive/<commit>.tar.gz";
    })).overlay
  ];

  environment.systemPackages = [ pkgs.<packageName> ];
}
```

### Home Manager

In your `home.nix`:

```nix
{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/<owner>/<repo>/archive/<commit>.tar.gz";
    })).overlay
  ];

  home.packages = [ pkgs.<packageName> ];
}
```