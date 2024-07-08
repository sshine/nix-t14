{ config, pkgs, ... }:

{
  # Enable Wayland and Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    wl-clipboard
    grim
    slurp
  ];

  # Configure XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Configure user session
  services.displayManager.defaultSession = "hyprland";
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
  };
}
