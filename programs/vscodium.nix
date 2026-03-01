{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscodium;
      vscodeExtensions = with vscode-extensions; [
        # General
        eamodio.gitlens
        asvetliakov.vscode-neovim
        skellock.just
        # continue.continue
        myriad-dreamin.tinymist

        # Nix
        bbenoist.nix
        kamadorueda.alejandra

        # Rust
        rust-lang.rust-analyzer
        serayuzgur.crates
        tamasfe.even-better-toml
        mkhl.direnv
      ];
    })
  ];
}
