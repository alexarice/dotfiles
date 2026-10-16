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
        ../core
      ];

      machine = "pi-container";

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
        opencode
        basedpyright
      ];

      hm = {
        imports = [
          ../modules/pi.nix
        ];

        programs.pi = {
          enable = true;
          settings = {
            packages = [
              "npm:pi-elm-models"
              "npm:pi-subagents"
              "npm:@juicesharp/rpiv-ask-user-question"
              "npm:@juicesharp/rpiv-todo"
              ../pkgs/pi/pi-builtin
              ../pkgs/pi/pi-date
            ];
            editorPaddingX = 1;
            terminal.hyperlinks = true;
          };
          skills = [
            ../pkgs/pi/web-search
          ];
        };
      };
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
