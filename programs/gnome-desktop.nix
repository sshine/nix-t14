{ pkgs, ... }:

{
  imports = [
    ./desktop-fonts.nix
    ./desktop-common.nix
  ];

  services.xserver = {
    enable = true;
    xkb.layout = "dk";
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.autoSuspend = false;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-tweaks
  ];

  environment.gnome.excludePackages =
    let
      exclude-1 = (with pkgs; [
        cheese
        epiphany
        geary
        gedit
        gnome-photos
        gnome-tour
        yelp
      ]);

      exclude-2 = (with pkgs.gnome; [
        gnome-music
        gnome-characters
        tali
        iagno
        hitori
        atomix
        gnome-contacts
        gnome-initial-setup
      ]);
    in
      exclude-1 ++ exclude-2;
}
