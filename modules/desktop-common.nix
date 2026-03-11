{ ... }:
{
  flake.nixosModules.desktop-common =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kitty
        firefox
      ];
    };
}
