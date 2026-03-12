{ inputs, config, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.t14 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ../hosts/t14/hardware-configuration.nix
      config.flake.nixosModules.boot
      config.flake.nixosModules.networking
      config.flake.nixosModules.user-sshine
      config.flake.nixosModules.system-packages
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
      config.flake.nixosModules.walltime
      { system.stateVersion = "24.05"; }
    ];
  };
}
