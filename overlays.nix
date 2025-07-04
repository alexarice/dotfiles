{
  inputs,
  lib,
  ...
}: let
  my-pkgs = import inputs.my-nixpkgs {
    system = "x86_64-linux";
  };

  overlays = {
    emacs = inputs.emacs-overlay.overlay;
    # wayland = self: super: removeAttrs (inputs.nixpkgs-wayland.overlay self super) ["sway-unwrapped" "wlroots" "wldash"];
    agda = inputs.all-agda.overlay."x86_64-linux";

    texpresso = self: super: {
      texpresso-mode = my-pkgs.emacsPackages.texpresso;
    };

    ferrishot = self: super: {
      ferrishot = inputs.ferrishot.packages."x86_64-linux".default;
    };

    agda-default = self: super: {
      agdaPackages = self.agdaPackages-2_7_0;
      agda = self.agda-2_7_0;
    };
    # discord = self: super: {
    #   discord =
    #     (import inputs.master {
    #       system = "x86_64-linux";
    #       config.allowUnfree = true;
    #     })
    #     .discord;
    # };
    fmt6overlay = self: super: {
      fmt_6 = super.fmt;
    };

    discordpyOverlay = self: super: {
      python37 = super.python37.override {
        packageOverrides = pself: psuper: {
          discordpy = psuper.discordpy.overrideAttrs (attrs: {
            patchPhase = ''
              substituteInPlace "requirements.txt" \
              --replace "aiohttp>=3.6.0,<3.7.0" "aiohttp>=3.6.0,<3.8.0" \
            '';
          });
        };
      };
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
in {
  options.overlays = lib.mkOption {
    type = lib.types.listOf lib.types.unspecified;
    default = [];
  };
  config.overlays = builtins.attrValues overlays;
}
