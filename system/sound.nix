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
    audio.enable = true;
    wireplumber = {
      enable = true;
      # WirePlumber 0.5.x configuration - disable headset mode autoswitch
      # See: https://pipewire.pages.freedesktop.org/wireplumber/daemon/configuration/bluetooth.html
      extraConfig."99-bluetooth-headset" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
          "bluetooth.use-persistent-storage" = false;
          "bluetooth.profile-preference" = "quality";
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
