{ ... }:
{
  flake.nixosModules.networking =
    { lib, ... }:
    {
      networking.hostName = "t14";
      networking.domain = "mechanicus.xyz";

      time.timeZone = lib.mkDefault "Europe/Copenhagen";

      networking.useDHCP = lib.mkDefault true;
      networking.networkmanager.enable = true;

      services.libinput.enable = true;

      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
}
