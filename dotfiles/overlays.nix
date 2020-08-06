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

  styxOverlay = self: super: {
    styx = super.styx.overrideAttrs (oldAttrs: {
      src = ../styx;
    });
  };

  nssFixOverlay = self: super: {
    discord = super.discord.override { nss = super.nss_3_44; };
    spotify = super.spotify.override { nss = super.nss_3_44; };
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
}
