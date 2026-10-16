{
  lib,
  inputs,
  ...
}: {
  imports = (import ../lib {inherit lib;}).importFiles ./.;

  options = {
    machine = lib.mkOption {
      type = lib.types.enum [
        "framework"
        "desktop"
        "wsl"
        "pi-container"
      ];
    };
  };
  config = {
    programs.fish.enable = true;

    system = {
      configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
      stateVersion = "26.11";
    };

    i18n.defaultLocale = "en_GB.UTF-8";
    time.timeZone = "Europe/London";
  };
}
