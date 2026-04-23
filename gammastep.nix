{
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
