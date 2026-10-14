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

  containers.pi-sandbox = {
    specialArgs.inputs = inputs;
    config = {pkgs, ...}: {
      imports = [
        ./core
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
