{
  imports = [
    ./core
    ./dev
    ./gui
    ./system
  ];

  config = {
    i18n.defaultLocale = "en_GB.UTF-8";
    console.useXkbConfig = true;
    time.timeZone = "Europe/London";

    services.dbus.enable = true;
    services.fstrim.enable = true;
    services.timesyncd.enable = true;
  };
}
