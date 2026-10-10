{
  config,
  lib,
  ...
}:
with lib; {
  options = {
    preamble = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Items to be put at the top of <filename>init.el</filename>. Should not rely on any package.
      '';
    };

    packageSetup = mkOption {
      type = types.str;
      visible = false;
      readOnly = true;
    };

    postSetup = mkOption {
      type = types.separatedString "\n\n";
      default = "";
      description = ''
        Text to be put after package initialisation in <filename>init.el</filename>.
      '';
    };

    configFile = mkOption {
      type = types.separatedString "\n\n";
      visible = false;
      readOnly = true;
    };

    rawPackageList = mkOption {
      type = types.listOf types.package;
      visible = false;
      readOnly = false;
    };

    externalPackageList = mkOption {
      type = types.listOf types.package;
      visible = false;
      readOnly = false;
    };
  };

  config.configFile = ''
    ;; Preamble
    ${config.preamble}

    ;; Packages
    ${config.packageSetup}

    ;; Post package initialisation
    ${config.postSetup}
  '';
}
