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
        ./git.nix
        ./direnv.nix
        ./fish.nix
      ];

      config = {
        nixpkgs.config = {
          allowBroken = true;
          allowUnfree = true;
          allowUnsupportedSystem = true;
          oraclejdk.accept_license = true;
        };

        nixpkgs.overlays = config.nixpkgs.overlays;

        home.stateVersion = "20.09";
      };
    };
  };
}
