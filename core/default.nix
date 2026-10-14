{
  lib,
  inputs,
  ...
}: let
  # Discover all .nix files in this directory (except default.nix)
  files = builtins.readDir ./.;
  nixFiles =
    lib.filterAttrs (
      name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
    )
    files;
  importList = lib.mapAttrsToList (name: _: ./${name}) nixFiles;
in {
  imports = importList;

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
