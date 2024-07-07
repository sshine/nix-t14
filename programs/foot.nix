{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      term = "xterm-256color";
      font = "monospace:size=20";
    };
  };
}
