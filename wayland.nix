{pkgs, ...}: {
  imports = [
    ./sway.nix
    ./noctalia.nix
  ];

  hardware = {
    graphics.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = "wlr";
      };
    };
    wlr = {
      enable = true;
      settings.screencast = {
        output_name = "eDP-1";
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
      };
    };
    xdgOpenUsePortal = true;
  };

  environment.systemPackages = with pkgs; [
    wdisplays
    wlprop
    wl-clipboard
  ];

  programs.yazi.enable = true;
}
