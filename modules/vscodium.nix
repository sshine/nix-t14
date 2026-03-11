{ ... }:
{
  flake.nixosModules.vscodium =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (vscode-with-extensions.override {
          vscode = vscodium;
          vscodeExtensions = with vscode-extensions; [
            eamodio.gitlens
            asvetliakov.vscode-neovim
            skellock.just
            myriad-dreamin.tinymist

            bbenoist.nix
            kamadorueda.alejandra

            rust-lang.rust-analyzer
            serayuzgur.crates
            tamasfe.even-better-toml
            mkhl.direnv
          ];
        })
      ];
    };
}
