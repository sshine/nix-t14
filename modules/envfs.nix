{ ... }:
{
  flake.nixosModules.envfs =
    { ... }:
    {
      services.envfs.enable = true;
    };
}
