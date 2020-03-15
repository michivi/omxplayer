{ pkgs ? import <nixpkgs> {
    crossSystem = (import <nixpkgs/lib>).systems.examples.raspberryPi;
    }
}:
let
    deps = import ./deps.nix pkgs;
in pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [ pkgconfig autoconf automake gcc ];
    buildInputs = builtins.attrValues deps;

    shellHook = ''
        export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE $(pkg-config dbus-1 --cflags)"
    '';
}