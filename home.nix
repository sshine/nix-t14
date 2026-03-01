{
  config,
  pkgs,
  ...
}: {
  home.username = "sshine";
  home.homeDirectory = "/home/sshine";

  programs.kitty = {
    enable = true;
    # theme = "Batman";
    font = {
      name = "Meslo";
      size = 14;
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        font = "Meslo:size=20";
        anchor = "center";
        horizontal-pad = 10;
        vertical-pad = 10;
      };
      colors = {
        background = "1b1d1edd";
        text = "6e6e6eff";
        match = "1b1d1e80"; # fg for matched substring
        selection = "4d4f4c80"; # bg
        selection-text = "505354ff"; # fg
        border = "1b1d1eff";
      };
      border = {
        width = 1;
        radius = 5;
      };
    };
  };

  programs.waybar.settings.mainBar = {
    position = "bottom";
    layer = "top";
    # output = "eDP-1"; # testing
    height = 5;
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 0;
    margin-right = 0;
    modules-left = [
      "custom/launcher"
      "hyprland/workspaces"
    ];
    modules-center = [
      "clock"
    ];
    modules-right = [
      "tray"
      "cpu"
      "memory"
      "disk"
      "pulseaudio"
      "battery"
      "network"
      "custom/notification"
    ];
    clock = {
      calendar = {
        format = {today = "<span color='#b4befe'><b><u>{}</u></b></span>";};
      };
      format = " {:%H:%M}";
      tooltip = "true";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = " {:%d/%m}";
    };
    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "󰈹";
        "2" = "";
        "3" = "󰘙";
        "4" = "󰙯";
        "5" = "";
        "6" = "";
        urgent = "";
        default = "";
        sort-by-number = true;
      };
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };
    memory = {
      format = "󰟜 {}%";
      format-alt = "󰟜 {used} GiB"; # 
      interval = 2;
    };
    cpu = {
      format = "  {usage}%";
      format-alt = "  {avg_frequency} GHz";
      interval = 2;
    };
    disk = {
      # path = "/";
      format = "󰋊 {percentage_used}%";
      interval = 60;
    };
    network = {
      format-wifi = "  {signalStrength}%";
      format-ethernet = "󰀂 ";
      tooltip-format = "Connected to {essid} {ifname} via {gwaddr}";
      format-linked = "{ifname} (No IP)";
      format-disconnected = "󰖪 ";
    };
    tray = {
      icon-size = 20;
      spacing = 8;
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "  {volume}%";
      format-icons = {
        default = [" "];
      };
      scroll-step = 5;
      on-click = "pamixer -t";
    };
    battery = {
      format = "{icon} {capacity}%";
      format-icons = [" " " " " " " " " "];
      format-charging = " {capacity}%";
      format-full = " {capacity}%";
      format-warning = " {capacity}%";
      interval = 5;
      states = {
        warning = 20;
      };
      format-time = "{H}h{M}m";
      tooltip = true;
      tooltip-format = "{time}";
    };
    "custom/launcher" = {
      format = "";
      on-click = "fuzzel";
      # on-click-right= "wallpaper-picker";
      tooltip = "false";
    };
    #"custom/notification" = {
    #    tooltip = false;
    #    format = "{icon} ";
    #    format-icons = {
    #        notification = "<span foreground='red'><sup></sup></span>   ";
    #        none = "   ";
    #        dnd-notification = "<span foreground='red'><sup></sup></span>   ";
    #        dnd-none = "   ";
    #        inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
    #        inhibited-none = "   ";
    #        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>   ";
    #        dnd-inhibited-none = "   ";
    #    };
    #    return-type = "json";
    #    exec-if = "which swaync-client";
    #    exec = "swaync-client -swb";
    #    on-click = "swaync-client -t -sw";
    #    on-click-right = "swaync-client -d -sw";
    #    escape = true;
    #};
  };

  # TODO(sshine): Adding this causes conflict because ~/.ssh is already manually populated.
  #
  #  programs.ssh = {
  #    enable = true;
  #    matchBlocks = {
  #      zhen = {
  #        user = "sshine";
  #        hostname = "zhen.mechanicus.xyz";
  #        port = 222;
  #      };
  #      dao = {
  #        user = "sshine";
  #        hostname = "dao.mechanicus.xyz";
  #        port = 222;
  #      };
  #      github = {
  #        user = "git";
  #        hostname = "github.com";
  #        port = 22;
  #      };
  #    };
  #  };

  # TODO(sshine): Complete this configuration based on auto-generated starter
  #
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
      package = pkgs.adwaita-icon-theme;
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
