{
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0b56cf87-4c83-4ffb-a3fa-7c6cba676414";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."cryptroot".device =
    "/dev/disk/by-uuid/656718e6-00b9-481c-959d-214d886d8f2f";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/44FD-18D2";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  system.stateVersion = "24.05";
}
