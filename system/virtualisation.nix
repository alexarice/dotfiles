{
  pkgs,
  inputs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  virtualisation.containers.enable = true;

  containers.container = {
    specialArgs.inputs = inputs;
    config = {pkgs, ...}: {
      imports = [
        ../core
      ];

      machine = "container";

      environment.systemPackages = with pkgs; [
        git
      ];

      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      hm.home.packages = with pkgs; [
        bash
        ripgrep
        curl
        nodejs
        python314
        ddgr
        basedpyright
        (inputs.nixpkgs-opencode.legacyPackages."x86_64-linux".opencode)
      ];
    };

    bindMounts = {
      "/home/alex/software" = {
        hostPath = "/home/alex/software";
        isReadOnly = false;
      };
      "/home/alex/dotfiles" = {
        hostPath = "/home/alex/dotfiles";
        isReadOnly = false;
      };
      "/home/alex/research" = {
        hostPath = "/home/alex/research";
        isReadOnly = true;
      };
    };
  };
}
