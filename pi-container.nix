{...}: {
  flake.nixosModules.pi-container = {pkgs, ...}: {
    imports = [
      ./core.nix
      ./nix.nix
      ./users.nix
    ];

    machine = "pi-container";

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

    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
  };
}
