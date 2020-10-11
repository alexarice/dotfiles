{
  emacsOverlay = import <emacs>;

  waylandOverlay = import <nixpkgs-wayland>;

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    });
  };

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

  gammastep = self: super: {
    gammastep = super.gammastep.overrideAttrs (attr: {
      postInstall = ''
        ln $out/bin/gammastep $out/bin/redshift
        ln $out/bin/gammastep-indicator $out/bin/redshift-gtk
      '';
    });
  };
}
