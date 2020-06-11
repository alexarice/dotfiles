{
  emacsOverlay = import <emacs>;

  myWaylandOverlay = import <nixpkgs-wayland>;

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    });
  };

  cattOverlay = self: super: {
    catt = (self.pkgs.callPackage ./pkgs/catt { });
  };

  styxOverlay = self: super: {
    styx = super.styx.overrideAttrs (oldAttrs: {
      src = ../styx;
    });
  };

  amdvlkOverlay = self: super: {
    inherit (import ../nixpkgs { }) amdvlk;
  };
}
