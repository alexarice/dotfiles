{ ... }: {
  nixpkgs.overlays = builtins.attrValues {
    fmt6overlay = self: super: {
      fmt_6 = super.fmt;
    };

    discordpyOverlay = self: super: {
      python37 = super.python37.override {
	      packageOverrides = pself: psuper: {
	        discordpy = psuper.discordpy.overrideAttrs(attrs: {
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
}
