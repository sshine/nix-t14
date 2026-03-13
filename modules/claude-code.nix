{ inputs, ... }:
{
  flake.nixosModules.packages =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        claude-code
        inputs.claudebox.packages.x86_64-linux.claudebox
      ];
    };
}
