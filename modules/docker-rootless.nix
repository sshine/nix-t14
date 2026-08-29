{ ... }:
{
  flake.nixosModules.docker-rootless =
    { pkgs, ... }:
    {
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
}
