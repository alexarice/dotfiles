let
  waylandOverlay = import (builtins.fetchTarball {
    url = https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz;
  });
in
{
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };

  brilloOverlay = self: super: {
    inherit (import /home/alex/nixpkgs { }) brillo;
  };

#  emacsOverlay = import (builtins.fetchTarball {
#    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
#  });

  myWaylandOverlay = self: super: {
    inherit (waylandOverlay {} super) redshift-wayland wldash;
  };

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) { configurationFile = /home/alex/dotfiles/nixmacsConf.nix;  });
  };

  fishOverlay = self: super: {
    fish = (super.fish.overrideAttrs (old: {
      src = self.pkgs.fetchFromGitHub {
        owner = "fish-shell";
        repo = "fish-shell";
        rev = "c6ec4235136e82c709e8d7b455f7c463f9714b48";
        sha256 = "0cl7kwqqrq4zkfhz4s19vjad62v7ddqk93x3z068nvzs0lfjcrj9";
      };
    }));
  };

  waybarOverlay = self: super: {
    waybar = super.waybar.override { pulseSupport = true; };
  };
}
