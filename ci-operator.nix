{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [
    pkgs.age
    pkgs.sops
    pkgs.ssh-to-age
  ];

  # FIXME(sshine): Get 'sshine' from environment
  home-manager.users.sshine = {
    home.stateVersion = "24.05"; # FIXME(sshine): Sync with somewhere!
    xdg.configFile."sops/age/keys.txt".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/keys.txt";
  };
}
