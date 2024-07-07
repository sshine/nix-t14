{ config, pkgs, ... }:

{
  programs.light.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # terminal = "kitty";
    #startup = [
    #  { command = "kitty"; }
    #  { command = "firefox"; }
    #];
  };
}
