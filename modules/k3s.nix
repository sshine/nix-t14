{ ... }:
{
  flake.nixosModules.k3s =
    { pkgs, ... }:
    {
      services.k3s = {
        enable = true;
        role = "server";
        extraFlags = [
          "--write-kubeconfig-group=k3s"
          "--write-kubeconfig-mode=0640"
        ];
      };

      networking.firewall.allowedTCPPorts = [ 6443 ];
      users.groups.k3s = { };
      users.users.sshine.extraGroups = [ "k3s" ];
      environment.systemPackages = [ pkgs.k3s ];
    };
}
