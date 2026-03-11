{ inputs, ... }:
{
  flake.nixosModules.system-packages =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = with pkgs; [
        wget
        curl
        screen
        zsh
        starship
        atuin
        alacritty
        foot
        kitty
        firefox
        gitFull
        signal-desktop
        simplex-chat-desktop
        direnv
        grim
        slurp
        wl-clipboard
        jq
        fd

        typst

        dnsutils
        doggo
        ldns
        aria2
        socat
        nmap
        ipcalc

        discord

        zed-editor
        helix
        just

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
        claude-code
        nixos-shell
        inputs.claudebox.packages.x86_64-linux.claudebox
      ];

      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "discord"
          "claude-code"
        ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
