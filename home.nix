{
  config,
  lib,
  inputs,
  ...
}:
with lib; {
  options.hm = mkOption {
    type = types.deferredModule;
  };

  config.home-manager = {
    extraSpecialArgs = inputs;
    users.alex = {
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
  };
}
