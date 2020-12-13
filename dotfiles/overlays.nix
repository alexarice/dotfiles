{
  emacsOverlay = import <emacs>;

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    });
    nixmacsrpi = let
	    src = builtins.fetchTarball { url = "https://github.com/alexarice/nixmacs/archive/master.tar.gz"; };
	  in self.pkgs.callPackage src {
	    configurationFile = /home/alex/dotfiles/nixmacs-conf-rpi.nix;
	  };
  };

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

  myWaylandOverlay = self: super: builtins.removeAttrs (import <nixpkgs-wayland> self super) [ ];

  cattOverlay = self: super: {
    catt = (self.pkgs.callPackage ./pkgs/catt { });
  };

  # pipewireNoBT = self: super: {
  #   pipewire = super.pipewire.overrideAttrs (attrs: {
  #     mesonFlags = attrs.mesonFlags ++ [
  #       "-Dbluez5=false"
  #       "-Dbluez-backend-native=false"
  #       "-Dbluez-backend-ofono=false"
  #     ];
  #   });
  # };

  zoomOverlay = self: super: {
    my-zoom = self.zoom-us.overrideAttrs (attrs: {
      pname = "my-zoom";
      qtWrapperArgs = attrs.qtWrapperArgs ++ [
        ''--prefix GDK_BACKEND : "x11"''
      ];
    });
  };

  gammastepOverlay = self: super: {
    gammastep = super.gammastep.overrideAttrs (attr: {
      postInstall = ''
        ln $out/bin/gammastep $out/bin/redshift
        ln $out/bin/gammastep-indicator $out/bin/redshift-gtk
      '';
    });
  };

  discordOverlay = self: super: {
    discord = (import <master> { config = { allowUnfree = true; }; }).discord;
  };
}
