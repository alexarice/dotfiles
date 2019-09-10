{ ... }:

let
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };

  emacsOverlay = import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  });

  waylandOverlay = import (builtins.fetchTarball {
    url = https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz;
  });

  myWaylandOverlay = self: super: {
    inherit (waylandOverlay {} super) redshift-wayland wldash;
  };
in
{
  nixpkgs.overlays = [ antOverlay emacsOverlay myWaylandOverlay ];
}
