{ inputs, config, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.t14 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../hosts/t14-hardware.nix
      config.flake.nixosModules.boot
      config.flake.nixosModules.swap
      config.flake.nixosModules.networking
      config.flake.nixosModules.user-sshine
      config.flake.nixosModules.system
      config.flake.nixosModules.packages
      config.flake.nixosModules.flake-packages
      config.flake.nixosModules.zsh
      config.flake.nixosModules.nixvim
      config.flake.nixosModules.vscodium
      config.flake.nixosModules.direnv
      config.flake.nixosModules.gnome-desktop
      config.flake.nixosModules.desktop-fonts
      config.flake.nixosModules.desktop-common
      config.flake.nixosModules.sshd
      config.flake.nixosModules.avahi-mdns
      config.flake.nixosModules.tailscale
      config.flake.nixosModules.gitconfig
      config.flake.nixosModules.hjem
      config.flake.nixosModules.trix
      config.flake.nixosModules.k3s
      config.flake.nixosModules.rust-overlay
      config.flake.nixosModules.flat-remix-gtk
      config.flake.nixosModules.docker-rootless
      config.flake.nixosModules.envfs
      config.flake.nixosModules.speech2text
    ];
  };
}
