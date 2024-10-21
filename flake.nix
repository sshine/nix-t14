{
  description = "Simon's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # on-prem-ci.url = "git+file:///home/sshine/Projects/umag/azure/on-prem-ci";
    # on-prem-ci.inputs.nixpkgs.follows = "nixpkgs";

    secrix.url = "github:Platonic-Systems/secrix";
    # rust-overlay.url = "github:oxalica/rust-overlay";
    # rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    secrix,
    home-manager,
    # on-prem-ci,
    ...
  } @ inputs: {
    apps.x86_64-linux.secrix = secrix.secrix self;

    nixosConfigurations = {
      t14 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          # on-prem-ci.nixosModules.ci-builder-laminar

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;
            home-manager.users.sshine = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
