{ config, pkgs, ... }:

{
  home.username = "sshine";
  home.homeDirectory = "/home/sshine";

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
    ];
  };

#  wayland.windowManager.hyprland.settings = {
#    # Keyboard and mouse
#    # input = {
#    #   kb_layout = "dk";
#    #  kb_variant = "";
#      kb_model = "";
#      kb_options = "";
#      kb_rules = "";
#
#      follow_mouse = 1;
#      sensitivity = 0;
#
#      touchpad = {
#        natural_scroll = false;
#      };
#    };
#
#    "$mod" = "SUPER"; # Win-key
#    "$terminal" = "kitty";
#    "$fileManager" = "kitty nnn";
#    "$menu" = "wofi --show drun";
#
#    bind =
#      [
#        # Main commands
#        "$mod, Q, exec, $terminal" # TODO: remove
#        "$mod, Enter, exec, $terminal"
#        "$mod, F, exec, firefox"
#        "$mod, Print, exec, grim"
#        "$mod, P, exec, $menu"
#        "$mod SHIFT, K, killactive"
#
#        # Windowing
#        "$mod, T, togglegroup"
#      ]
#      ++ (
#        # workspaces
#        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
#        builtins.concatLists (builtins.genList (
#            x: let
#              ws = let
#                c = (x + 1) / 10;
#              in
#                builtins.toString (x + 1 - (c * 10));
#            in [
#              "$mod, ${ws}, workspace, ${toString (x + 1)}"
#              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
#            ]
#          )
#          10)
#      );
#  };
#
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

