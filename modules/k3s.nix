{ ... }:
{
  flake.nixosModules.k3s =
    { pkgs, ... }:
    {
      services.k3s = {
        enable = true;
        role = "server";
      };

      # Kubernetes API server.
      networking.firewall.allowedTCPPorts = [ 6443 ];

      environment.systemPackages = [ pkgs.k3s ];
    };
}
