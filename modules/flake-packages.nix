# My own Rust tools, taken from each project's GitHub release rather than built here.
#
# The source packages pull a Rust toolchain into the build closure, so a system
# upgrade recompiles them whenever their flake input moves. The `-bin` packages are
# a fetchurl of a static musl tarball instead, so an upgrade copies a few megabytes
# and links them in.
#
# Which release each one pins lives in that project's nix/binary.nix, so moving one
# onto a newer tag is a flake input bump rather than an edit here.
{ inputs, ... }:
{
  flake.nixosModules.flake-packages =
    { pkgs, ... }:
    let
      released = flake: flake.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = [
        (released inputs.walltime-rs).walltime-bin
        (released inputs.hashpinner).hashpinner-bin
        (released inputs.irciii).irciii-bin
      ];
    };
}
