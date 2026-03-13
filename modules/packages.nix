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

        firefox
        signal-desktop
        simplex-chat-desktop
        discord

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

        hyprland
        hyprpaper
        hyprshot
        waybar
        fuzzel
        wofi

        rustup
        cargo
        cargo-generate
        rustc
        rust-analyzer
        rustfmt
        gcc
        pkg-config
        cargo-watch

        parted
        gptfdisk
        nixos-generators
        shellcheck

        bottom
        brightnessctl
        dunst

        minicom
        usbutils

        qemu
        bat
        nixos-shell
      ];

      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
          "claude-code"
        ];
    };
}
