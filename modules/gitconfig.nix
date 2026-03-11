{ ... }:
{
  flake.nixosModules.gitconfig =
    { ... }:
    {
      programs.git = {
        enable = true;
        config = {
          user.name = "Simon Shine";
          user.email = "simon@simonshine.dk";
          push.autoSetupRemote = true;
        };
      };
    };
}
