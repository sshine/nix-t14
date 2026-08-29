{ ... }:
{
  flake.nixosModules.swap =
    { ... }:
    {
      # A file rather than a partition: the disk is fully allocated to the LUKS
      # container, and the swap inherits its encryption by living inside it.
      swapDevices = [
        {
          device = "/var/lib/swapfile";
          size = 16 * 1024;
        }
      ];
    };
}
