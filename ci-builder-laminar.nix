{
  pkgs,
  config,
  lib,
  home-manager,
  ...
}: let
  ciHomeDir = "/var/lib/laminar";
in {
  environment.systemPackages = [
    pkgs.laminar
    pkgs.age
    pkgs.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/ci.yaml;
    age.keyFile = "${ciHomeDir}/.config/sops/age/keys.txt";
  };

  users.users.ci = {
    isNormalUser = true;
    home = ciHomeDir;
    shell = pkgs.bash;
    description = "Laminar CI";

    openssh.authorizedKeys.keys = [
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICjsn8RBtdJzneALvXNwyrpFzb6GqzZnHRjjvMjXBzPW ssh@umag''
      ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPSkHpCcQrKFXuGLcUvYz/Fv4Fi7cMCa83lIBFCI7lCb ehn@umag''
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.ci = {
    home.stateVersion = "24.05"; # FIXME(sshine): Sync with somewhere!
    home.file."cfg/jobs/just-ci.run" = {
      # source = ./just-ci.run;
      text = ''
        #!/usr/bin/env sh

        set -ex

        COPY="firmwares-copy"

        cd "$HOME/repos"
        rm -rf "$COPY"
        git clone firmwares.git "$COPY"
        cd "$COPY"
        nix develop -c just ci
      '';
      target = "${ciHomeDir}/cfg/jobs/just-ci.run";
      executable = true; # chmod +x
      recursive = true; # create sub-directories
    };

    home.file.".ssh/id_rsa-source" = {
      text = config.sops.secrets.deploy-private-key;
      onChange = ''cat ~/.ssh/id_rsa-source > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa'';
    };

    home.file.".ssh/id_rsa.pub-source" = {
      text = config.sops.secrets.deploy-public-key;
      onChange = ''cat ~/.ssh/id_rsa.pub-source > ~/.ssh/id_rsa.pub && chmod 600 ~/.ssh/id_rsa.pub'';
    };
  };

  systemd.services.laminar = {
    enable = true;
    description = "Laminar CI";
    wantedBy = ["multi-user.target"];
    path = [
      pkgs.bash
      pkgs.coreutils
      pkgs.git
      pkgs.nix
      pkgs.openssh
    ];
    environment = {
      LAMINAR_HOME = ciHomeDir;
    };
    serviceConfig = {
      StateDirectory = "laminar"; # mkdir -p /var/lib/laminar
      ExecStart = "${pkgs.laminar}/bin/laminard";
      User = "ci";
      Group = "users";
    };
  };
}
