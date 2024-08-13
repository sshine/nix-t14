{ ... }:

let
  wgPort = 51820;
  wgClient = "10.100.0.2/32";
  wgSubnet = "10.100.0.0/16";
  wgServerPublic = "192.168.50.45";
  wgPrivKey = "/home/sshine/Projects/nixos/secrets/wireguard/private";
  wgPeers = [
    {
      publicKey = "C3NdkWjsFXA5Tl+G7T9YmFb5CiOIFkmW5EJdkdw6jEo=";
      allowedIPs = [ "10.100.0.0/16" ];
      endpoint = "${wgServerPublic}:${toString wgPort}";
      persistentKeepalive = 25;
      # FIXME(sshine): route to endpoint not automatically configured
      # https://wiki.archlinux.org/index.php/WireGuard#Loop_routing
      # https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
    }
  ];
in
{
  networking.firewall = {
    allowedUDPPorts = [ wgPort ];
  };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ wgClient ];
      listenPort = wgPort;
      privateKeyFile = wgPrivKey;
      peers = wgPeers;
    };
  };
}
