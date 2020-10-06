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

  gammastep = self: super: {
    gammastep = super.gammastep.overrideAttrs (attr: {
      postInstall = ''
        ln $out/bin/gammastep $out/bin/redshift
        ln $out/bin/gammastep-indicator $out/bin/redshift-gtk
      '';
    });
  };
}
