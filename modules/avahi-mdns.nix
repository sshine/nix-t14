{ ... }:
{
  flake.nixosModules.avahi-mdns =
    { ... }:
    {
      services.avahi = {
        enable = true;
        nssmdns4 = true;
      };
    };
}
