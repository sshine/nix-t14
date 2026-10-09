{ inputs, ... }:
{
  flake.nixosModules.packages =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        screen
        atuin
        alacritty
        kitty
        herdr
        ffmpeg

        firefox
        thunderbird
        signal-desktop
        simplex-chat-desktop
        discord
        spotify
        mpv

        direnv
        grim
        slurp
        wl-clipboard

        typst

        dnsutils
        doggo
        ldns
        aria2
        socat
        nmap
        ipcalc

        zed-editor
        just

        jq
        fd
        wget
        curl
        gitFull
        github-cli
        zsh
        nnn
        gnused
        zip
        xz
        unzip
        p7zip
        zstd
        gnutar
        gnupg
        ripgrep
        eza
        fzf
        mtr
        file
        which
        tree
        nix-index
        htop
        killall

        # hyprland
        # hyprpaper
        # hyprshot
        # waybar
        fuzzel
        wofi

        gcc
        pkg-config

        parted
        gptfdisk
        nixos-generators
        shellcheck

        bottom
        brightnessctl
        dunst
        cloc

        minicom
        usbutils

        qemu
        bat
        nixos-shell
        passage
        age
      ];

      nixpkgs.config.allowUnfree = true;
      #nixpkgs.config.allowUnfreePredicate =
      #  pkg:
      #  builtins.elem (lib.getName pkg) [
      #    "discord"
      #    "claude-code"
      #  ];
    };
}
