{ inputs, ... }:
{
  flake.nixosModules.flake-packages =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        inputs.walltime-rs.overlays.default
        inputs.hashpinner.overlays.default
      ];
      environment.systemPackages = [
        pkgs.walltime
        pkgs.hashpinner
      ];
    };
}
