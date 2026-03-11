{ ... }:
{
  flake.nixosModules.networking =
    { lib, ... }:
    {
      networking.hostName = "t14";
      networking.domain = "mechanicus.xyz";

      time.timeZone = lib.mkDefault "Europe/Copenhagen";

      services.libinput.enable = true;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
