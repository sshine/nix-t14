{ config, pkgs, ... }:

{
  # FIXME: Works with fcitx5-rime + rime-data, but this is traditional chinese
  # FIXME: Theme=Nord-Dark in ~/.config/fcitx5/conf/classicui.conf
  # FIXME: requires additional settings in hyprland.conf

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-nord
    ];
  };

  # FIXME: Doesn't work well for Wayland, they say. Doesn't work at all for me.
  #i18n.inputMethod = {
  #  enabled = "ibus";
  #  ibus.engines = [ pkgs.ibus-engines.libpinyin ];
  #};

}
