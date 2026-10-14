{inputs, ...}: let
  wsl-module = {
    pkgs,
    lib,
    ...
  }: {
    machine = "wsl";

    wsl = {
      enable = true;
      wslConf.automount.root = "/mnt";
      defaultUser = "alex";
      startMenuLaunchers = true;
    };

    services.xserver.enable = true;
    services.xserver.xkb.layout = "gb";
    services.xserver.xkb.variant = "dvorak";

    users.users.alex.shell = lib.mkForce pkgs.fish;

    environment.systemPackages = with pkgs; [
      ripgrep
      setxkbmap
      docker
      # Dictionaries
      aspell
      aspellDicts.en
    ];
  };
in {
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs.inputs = inputs;
    modules = [
      ./core
      ./cachix.nix
      ./direnv.nix
      ./documents.nix
      ./emacs
      ./fonts.nix
      ./helix.nix
      ./programming.nix
      ./terminal.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nixos-wsl.nixosModules.wsl
      wsl-module
    ];
  };
}
