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
        inputs.emacs-nix.nixosModules.emacs-nix
        ./emacs.nix
        ./direnv.nix
        ./fish.nix
      ];

      config = {
        home.stateVersion = "20.09";
      };
    };
  };
}
