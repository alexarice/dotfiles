{inputs, ...}: let
  wsl-module = {pkgs, ...}: {
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

    # Load fonts
    fonts = {
      packages = with pkgs; [
        nerd-fonts.hack
        symbola
        dejavu_fonts
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = ["SauceCodePro Nerd Font Mono"];
          sansSerif = ["DejaVu Sans"];
          serif = ["DejaVu Serif"];
        };
      };
    };
    environment.systemPackages = with pkgs; [
      git
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
      ./core.nix
      inputs.home-manager.nixosModules.home-manager
      inputs.nixos-wsl.nixosModules.wsl
      wsl-module
    ];
  };
}
