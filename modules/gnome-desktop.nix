{ ... }:
{
  flake.nixosModules.gnome-desktop =
    { pkgs, ... }:
    {
      services.xserver = {
        enable = true;
        xkb.layout = "dk";
      };

      services.desktopManager.gnome.enable = true;
      services.displayManager.gdm.enable = true;
      services.displayManager.gdm.autoSuspend = false;

      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [
        gnome-tweaks
      ];

      environment.gnome.excludePackages = with pkgs; [
        cheese
        epiphany
        geary
        gedit
        gnome-photos
        gnome-tour
        yelp
        gnome-music
        gnome-characters
        tali
        iagno
        hitori
        atomix
        gnome-contacts
        gnome-initial-setup
      ];
    };
}
