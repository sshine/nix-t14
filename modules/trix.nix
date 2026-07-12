{ inputs, ... }:
{
  flake.nixosModules.trix =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        inputs.trix.packages.${pkgs.stdenv.hostPlatform.system}.trix
      ];
    };
}
