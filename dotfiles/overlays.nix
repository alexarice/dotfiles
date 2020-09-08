{
  emacsOverlay = import <emacs>;

  waylandOverlay = import <nixpkgs-wayland>;

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
      package = self.emacs-pgtk;
    });
  };

  cattOverlay = self: super: {
    catt = (self.pkgs.callPackage ./pkgs/catt { });
  };

  pipewireNoBT = self: super: {
    pipewire = super.pipewire.overrideAttrs (attrs: {
      mesonFlags = attrs.mesonFlags ++ [
        "-Dbluez5=false"
        "-Dbluez-backend-native=false"
        "-Dbluez-backend-ofono=false"
      ];
    });
  };

  firefox-wayland = self: super: {
    firefox = let
      src = self.fetchFromGitHub {
        owner = "colemickens";
        repo = "nixpkgs";
        rev = "nixpkgs-firefox-pipewire";
        sha256 = "1n26zad06gm768bf2vhz1r8z5csz1cdr3bfpahknzbnzp3q0hzhm";
      };
      in (import src { }).firefox;
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
