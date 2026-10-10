{
  config,
  lib,
  ...
}:
with lib; {
  options = {
    global-variables = mkOption {
      type = types.varBindType;
      default = {};
      description = ''
        Variables to be set.
      '';
    };

    global-variable-defaults = mkOption {
      type = types.varBindType;
      default = {};
      description = ''
        Set defaults for buffer-local variables.
      '';
    };

    global-modes = mkOption {
      type = types.attrsOf types.bool;
      default = {};
      description = ''
        Modes to enable/disable on startup.
      '';
    };
  };

  config.preamble = mkAfter ''
    ${printVariables config.global-variables}
    ${printDefaultVariables config.global-variable-defaults}

    ${concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${
        if value
        then "1"
        else "-1"
      })")
      config.global-modes)}
  '';
}
