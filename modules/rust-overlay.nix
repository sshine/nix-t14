{ inputs, ... }:
{
  flake.nixosModules.rust-overlay =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

      # The overlay pins a complete stable toolchain (rustc, cargo, clippy,
      # rustfmt, rust-std) via rust-bin, so rustup is not needed.
      environment.systemPackages = [
        (pkgs.rust-bin.stable.latest.default.override {
          extensions = [
            "rust-src"
            "rust-analyzer"
          ];
        })

        pkgs.cargo-generate
        pkgs.cargo-watch
      ];
    };
}
