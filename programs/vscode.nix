{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      tamasfe.even-better-toml
      serayuzgur.crates
      eamodio.gitlens
  };
}
