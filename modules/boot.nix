{ ... }:
{
  flake.nixosModules.boot =
    { ... }:
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      boot.binfmt.emulatedSystems = [
        "aarch64-linux"
        "x86_64-windows"
      ];

      console.keyMap = "dk";
    };
}
