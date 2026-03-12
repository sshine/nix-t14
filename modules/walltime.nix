{ inputs, ... }:
{
  flake.nixosModules.walltime =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [ inputs.walltime-rs.overlays.default ];
      environment.systemPackages = [ pkgs.walltime-cli ];
    };
}
