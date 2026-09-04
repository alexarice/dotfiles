{
  config,
  lib,
  inputs,
  ...
}:
with lib; {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.hm = mkOption {
    type = types.deferredModule;
  };

  config.home-manager = {
    backupFileExtension = "hm-backup";

    users.alex = { ... }: {
      imports = [
        config.hm
      ];

      config = {
        home.stateVersion = "20.09";
      };
    };
  };
}
