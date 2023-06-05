{
  self,
  config,
  lib,
  inputs,
  ...
}: {
  flake.nixosModules.wsl = {pkgs, ...}: let
    stateVersion = "22.11";
  in {
    imports = [
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nixos-wsl.nixosModules.wsl
    ];

    system.stateVersion = stateVersion;
    _module.args.inputs = inputs;
    home-manager.users.nixos = {lib, ...}: {
      imports = [
        ./git.nix
        ./fish.nix
        ./direnv.nix
        ./emacs.nix
        inputs.emacs-nix.nixosModules.emacs-nix
      ];
      programs.git.signing = lib.mkForce null;
      home.stateVersion = stateVersion;
    };

    users.users.nixos.shell = pkgs.fish;

    programs.fish.enable = true;

    wsl = {
      enable = true;
      wslConf.automount.root = "/mnt";
      defaultUser = "nixos";
      startMenuLaunchers = true;
    };
    nix.package = pkgs.nixVersions.stable;
    nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';
    services.xserver.enable = true;
    services.xserver.layout = "gb";
    services.xserver.xkbVariant = "dvorak";

    # Load fonts
    fonts = {
      fonts = with pkgs; [
        source-code-pro
        powerline-fonts
        symbola
        dejavu_fonts
        emacs-all-the-icons-fonts
        noto-fonts
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = ["Source Code Pro" "DejaVu Sans Mono"];
          sansSerif = ["DejaVu Sans"];
          serif = ["DejaVu Serif"];
        };
      };
    };

    nixpkgs = {
      inherit (config) overlays;
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
    environment.systemPackages = with pkgs; [
      git
      (inputs.nixmacs.fromConf ./wsl-nixmacs.nix)
      emacs
      ripgrep
      xorg.setxkbmap
      docker
      # Dictionaries
      aspell
      aspellDicts.en
    ];
  };

  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      self.nixosModules.wsl
    ];
  };
}
