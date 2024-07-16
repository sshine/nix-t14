{ config, pkgs, ... }:

{
  # FIXME: Move ~/.config/fcitx5/conf/classicui.conf configuration to home-manager
  # FIXME: Move ~/.config/hypr/hyprland.conf configuration to home-manager

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-nord
    ];
  };

}
