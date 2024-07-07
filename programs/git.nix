{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Simon Shine";
    userEmail = "simon@simonshine.dk";
    init = {
      defaultBranch = "main";
    };
  };
}
