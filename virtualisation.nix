{
  pkgs,
  inputs,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.containers.enable = true;
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
    quickemu
  ];

  containers.pi-sandbox = {
    config = {pkgs, ...}: {
      imports = [inputs.self.nixosModules.pi-container];
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
