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

  config.home-manager.users.alex = {
      pkgs,
      lib,
      ...
    }: {
      imports = [
        config.hm
      ];

      config = {
        home.stateVersion = "20.09";
      };
    };
}
