{pkgs, ...}: {
  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    wireplumber = {
      enable = true;
      extraConfig."11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };

  hm.home.packages = with pkgs; [
    blueman
    pavucontrol
    playerctl
  ];
}
