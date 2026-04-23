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
        ./foot.nix
        ./git.nix
        ./direnv.nix
        ./fish.nix
        ./sway.nix
      ];

      options = {
        dots = mkOption {
          type = types.path;
        };
        scripts = mkOption {
          type = types.path;
        };
        modifier = mkOption {
          type = types.str;
        };
        machine = mkOption {
          type = types.enum [
            "desktop"
            "framework"
          ];
        };
      };

      config = {
        nixpkgs.config = {
          allowBroken = true;
          allowUnfree = true;
          allowUnsupportedSystem = true;
          oraclejdk.accept_license = true;
        };

        services.kdeconnect = {
          enable = true;
          indicator = true;
        };

        nixpkgs.overlays = config.nixpkgs.overlays;

        dots = ./.;
        scripts = ./scripts;
        modifier = "Mod4";
        machine = config.machine;

        home.stateVersion = "20.09";
      };
    };
  };
}
