{
  overlays = [
    (self: super: {
      gammastep = super.gammastep.overrideAttrs (attr: {
        postInstall = ''
          ln $out/bin/gammastep $out/bin/redshift
          ln $out/bin/gammastep-indicator $out/bin/redshift-gtk
        '';
      });
    })
  ];

  services.geoclue2 = {
    enable = true;
    appConfig.gammastep = {
      isSystem = false;
      isAllowed = true;
    };
  };

  hm.services.gammastep = {
    enable = true;
    provider = "geoclue2";
    tray = true;
  };
}
