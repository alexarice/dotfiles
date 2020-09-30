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
        sha256 = "09c93dpz0fz1yk2b0qfy3v5bknnlbzrqd0h3damcc7q3dmc8ll3f";
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
