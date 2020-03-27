let
  waylandOverlay = import (builtins.fetchTarball {
    url = https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz;
  });
in
{
  emacsOverlay = import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  });

  myWaylandOverlay = waylandOverlay;

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    });
  };

  cattOverlay = self: super: {
    catt = (self.pkgs.callPackage ./pkgs/catt { });
  };
}
