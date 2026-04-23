{
  config,
  inputs,
  lib,
  ...
}: {
  options.overlays = lib.mkOption {
    type = lib.types.listOf lib.types.unspecified;
    default = [];
  };

  config = {
    overlays = builtins.attrValues {
      emacs = inputs.emacs-overlay.overlay;
      agda = inputs.all-agda.overlay."x86_64-linux";

      ferrishot = self: super: {
        ferrishot = inputs.ferrishot.packages."x86_64-linux".default;
      };

      agda-default = self: super: {
        agdaPackages = self.agdaPackages-2_8_0;
        agda = self.agda-2_8_0;
      };
      fmt6overlay = self: super: {
        fmt_6 = super.fmt;
      };

      gammastepOverlay = self: super: {
        gammastep = super.gammastep.overrideAttrs (attr: {
          postInstall = ''
            ln $out/bin/gammastep $out/bin/redshift
            ln $out/bin/gammastep-indicator $out/bin/redshift-gtk
          '';
        });
      };
    };

    nix = {
      settings = {
        trusted-users = ["root" "alex"];

        auto-optimise-store = true;
      };

      registry.nixpkgs.flake = inputs.nixpkgs;

      extraOptions = ''
        keep-outputs = true
        keep-derivations = true
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs = {
      inherit (config) overlays;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "openssl-1.1.1w"
        ];
      };
    };

    programs.command-not-found.enable = true;

    hm.nixpkgs = {
      config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        oraclejdk.accept_license = true;
      };
      inherit (config) overlays;
    };
  };
}
