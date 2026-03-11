{ ... }:
{
  flake.nixosModules.user-sshine =
    { pkgs, ... }:
    {
      users = {
        groups.plugdev = { };
        defaultUserShell = pkgs.zsh;

        users.sshine = {
          isNormalUser = true;
          home = "/home/sshine";
          shell = pkgs.zsh;
          description = "Simon Shine";
          extraGroups = [
            "wheel"
            "video"
            "plugdev"
            "dialout"
          ];
        };
      };

      security.polkit.enable = true;

      security.sudo = {
        enable = true;
        execWheelOnly = true;
        wheelNeedsPassword = false;
      };
    };
}
