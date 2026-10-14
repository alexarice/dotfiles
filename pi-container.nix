{...}: {
  flake.nixosModules.pi-container = {pkgs, ...}: {
    imports = [
      ./users.nix
    ];

    environment.systemPackages = with pkgs; [
      bash
      ripgrep
      curl
      pi-coding-agent
      nodejs
      git
      python314
      ddgr
    ];

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib
        zstd
        stdenv.cc.cc.lib
      ];
    };

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;

    programs.fish.enable = true;

    nix = {
      settings = {
        experimental-features = ["nix-command" "flakes"];
      };
    };

    system.stateVersion = "26.11";
  };
}
