{ config, lib, inputs, ... }:

{
  flake.nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      ./cachix.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nixos-wsl.nixosModules.wsl
      ({ pkgs, config, ... }: let
        stateVersion = "22.11";
      in {
        system.stateVersion = stateVersion;
        home-manager.users.nixos = { lib, ... }: {
          imports = [
            ./git.nix
            ./fish.nix
            ./direnv.nix
          ];
          programs.git.signing = lib.mkForce null;
          home.stateVersion = stateVersion;
        };

        users.users.nixos.shell = pkgs.fish;

        wsl = {
          enable = true;
          automountPath = "/mnt";
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
              monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
              sansSerif = [  "DejaVu Sans" ];
              serif = [  "DejaVu Serif" ];
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
          (nixmacs.fromConf ./wsl-nixmacs.nix)
	        emacs
          ripgrep
          xorg.setxkbmap
          docker
          # Dictionaries
          aspell
          aspellDicts.en
        ];
      })
    ];
  };
}
