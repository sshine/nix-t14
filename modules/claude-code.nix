{ inputs, ... }:
{
  flake.nixosModules.packages =
    {
      pkgs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      llm-pkgs = inputs.llm-agents.packages.${system};
      box-pkgs = inputs.bubblebox.packages.${system};
    in
    {
      environment.systemPackages = [
        pkgs.claude-code
        pkgs.opencode

        llm-pkgs.rtk
        llm-pkgs.codex
        # llm-pkgs.zeroclaw
        # llm-pkgs.pi

        box-pkgs.claudebox
        box-pkgs.opencodebox
        # box-pkgs.hermesbox

        # inputs.claudebox.packages.${system}.claudebox
      ];
    };
}
