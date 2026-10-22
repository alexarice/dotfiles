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

  hm.programs.fish.functions.copen = ''
    # Find -- separator index
    set sep_idx (contains -i -- "--" $argv)

    # Split args at separator
    if test -n "$sep_idx"
        set copen_args $argv[1..(math $sep_idx - 1)]
        set opencode_args $argv[(math $sep_idx + 1)..-1]
    else
        set copen_args $argv
        set opencode_args
    end

    # Parse copen flags with argparse
    argparse --min-args=1 --max-args=1 r/restart a/allow -- $copen_args || return 1

    set path $argv[1]

    # Container logic
    if test -n "$_flag_restart"
        echo "Restarting container..."
        sudo nixos-container restart container
    else if not sudo nixos-container status container | grep -q "up"
        echo "Starting container..."
        sudo nixos-container start container
    end

    # Run direnv allow
    if test -n "$_flag_allow"
        sudo nixos-container run container -- sh -c "cd $path && su alex -c 'direnv allow'"
        return 0
    end

    # Run opencode
    if test -n "$opencode_args"
        set escaped (string escape -- $opencode_args)
        sudo nixos-container run container -- sh -c "cd $path && su alex -c 'direnv exec . opencode $escaped'"
    else
        sudo nixos-container run container -- sh -c "cd $path && su alex -c 'direnv exec . opencode'"
    end
  '';

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
        texliveFull
      ];

      hm.programs.opencode.enable = true;
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
      "/home/alex/scratch" = {
        hostPath = "/home/alex/scratch";
        isReadOnly = false;
      };
    };
  };
}
