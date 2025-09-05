# AppFlake Template

This is a template repository for creating applications using Nix Flakes.

## Usage

1.  **Copy this repository.**
2.  **Modify `nix/variables.nix`** to match your project's needs.
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

## Language Examples

### C

**`nix/variables.nix`**

```nix
{
  pkgs, ...
}: {
  packageName = "my-c-app";
  buildInputs = [ pkgs.gcc pkgs.gnumake ];
  buildCommand = "make";
  installCommand = ''
    mkdir -p $out/bin
    cp my-c-app $out/bin
  '';
}
```

**`src/main.c`**

```c
#include <stdio.h>

int main() {
    printf("Hello, C!\n");
    return 0;
}
```

**`src/Makefile`**

```makefile
all:
	gcc -o my-c-app main.c
```

### Rust

**`nix/variables.nix`**

```nix
{
  pkgs, ...
}: {
  packageName = "my-rust-app";
  buildInputs = [ pkgs.rustc pkgs.cargo ];
  buildCommand = "cargo build --release";
  installCommand = ''
    mkdir -p $out/bin
    cp target/release/my-rust-app $out/bin
  '';
}
```

**`src/main.rs`**

```rust
fn main() {
    println!("Hello, Rust!");
}
```

**`src/Cargo.toml`**

```toml
[package]
name = "my-rust-app"
version = "0.1.0"
edition = "2021"

[dependencies]
```

### Python

**`nix/variables.nix`**

```nix
{
  pkgs, ...
}: {
  packageName = "my-python-app";
  buildInputs = [ pkgs.python3 ];
  buildCommand = ""; # No build command needed
  installCommand = ''
    mkdir -p $out/bin
    cp my-python-app.py $out/bin/my-python-app
    chmod +x $out/bin/my-python-app
  '';
}
```

**`src/my-python-app.py`**

```python
#!/usr/bin/env python

print("Hello, Python!")
```

### Expo (React Native)

**`nix/variables.nix`**

```nix
{
  pkgs, ...
}: {
  packageName = "my-expo-app";
  buildInputs = [ pkgs.nodejs pkgs.yarn ];
  buildCommand = "yarn install && yarn build";
  installCommand = ''
    mkdir -p $out/web-build
    cp -r web-build/* $out/web-build
  '';
}
```

To create an Expo app, you can run `npx create-expo-app` in the `src` directory.

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
