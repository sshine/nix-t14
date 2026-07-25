{
  description = "Simon's NixOS configuration";

  inputs = {
    nixpkgs.url = "https://nixos.org/channels/nixpkgs-unstable/nixexprs.tar.xz";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    # rtk
    llm-agents.url = "github:numtide/llm-agents.nix";
    llm-agents.inputs.nixpkgs.follows = "nixpkgs";
    llm-agents.inputs.flake-parts.follows = "flake-parts";
    llm-agents.inputs.treefmt-nix.follows = "treefmt-nix";

    # claudebox.url = "github:numtide/claudebox";
    # claudebox.inputs.nixpkgs.follows = "nixpkgs";
    # claudebox.inputs.treefmt-nix.follows = "treefmt-nix";
    bubblebox.url = "github:nix-tools/bubblebox";
    bubblebox.inputs.nixpkgs.follows = "nixpkgs";
    bubblebox.inputs.flake-parts.follows = "flake-parts";
    bubblebox.inputs.import-tree.follows = "import-tree";
    bubblebox.inputs.treefmt-nix.follows = "treefmt-nix";
    bubblebox.inputs.hermes-agent.inputs.nixpkgs.follows = "nixpkgs";
    bubblebox.inputs.hermes-agent.inputs.flake-parts.follows = "flake-parts";

    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    lefthook-nix.url = "github:sudosubin/lefthook.nix";
    lefthook-nix.inputs.nixpkgs.follows = "nixpkgs";

    trix.url = "github:aanderse/trix";
    trix.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    walltime-rs.url = "github:sshine/walltime-rs";
    walltime-rs.inputs.nixpkgs.follows = "nixpkgs";
    walltime-rs.inputs.flake-parts.follows = "flake-parts";
    walltime-rs.inputs.import-tree.follows = "import-tree";
    walltime-rs.inputs.lefthook-nix.follows = "lefthook-nix";
    walltime-rs.inputs.treefmt-nix.follows = "treefmt-nix";
    walltime-rs.inputs.rust-overlay.follows = "rust-overlay";
  };

  outputs =
    {
      self,
      flake-parts,
      import-tree,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } (import-tree ./modules);
}
