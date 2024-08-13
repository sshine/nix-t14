{ ... }:

{
  services.hydra = {
    enable = true;
    hydraURL = "http://thinkstation.local:3000";
    notificationSender = "hydra@umagsolutions.com";
    buildMachinesFiles = [];
    useSubstitutes = true;
  };
}
