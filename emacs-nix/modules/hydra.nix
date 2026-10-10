{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.hydra;
  hydraType = {
    name,
    config,
    ...
  }: {
    options = {
      name = mkOption {
        type = types.str;
        default = name;
        example = "hydra-zoom";
        description = ''
          Name of the hydra.
        '';
      };

      hint = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "nil";
        description = ''
          head-hint for the hydra.
        '';
      };

      docText = mkOption {
        type = with types; nullOr str;
        default = null;
        example = "zoom";
        description = ''
          Description for the hydra.
        '';
      };

      colour = mkOption {
        type = with types; nullOr (enum ["amaranth" "teal" "pink" "red" "blue"]);
        default = null;
        example = "amaranth";
        description = ''
          Hydra body colour.
        '';
      };

      bind = mkOption {
        type = types.str;
        default = "";
        example = ''"global-map \"<f2>\""'';
        description = ''
          Binding to run hydra on.
        '';
      };

      bindings = mkOption {
        type = with types; attrsOf (either str (submodule hydraBind));
        default = {};
        example = {
          "g" = {
            command = "text-scale-increase";
            name = "in";
          };
          "l" = {
            command = "text-scale-decrease";
            name = "out";
          };
        };
        apply = mapAttrs (name: value:
          if isString value
          then {
            command-text = ''("${name}" ${value})'';
          }
          else value);
        description = ''
          Bindings for this hydra.
        '';
      };

      hydra-text = mkOption {
        type = types.str;
        readOnly = true;
        visible = false;
      };
    };

    config = {
      hydra-text = ''
        (defhydra ${config.name} (${config.bind} ${
          if config.colour != null
          then ":color ${config.colour}"
          else ""
        } ${
          if config.hint != null
          then ":hint ${config.hint}"
          else ""
        })
        "${config.docText}"
        ${concatStringsSep "\n" (map (x: x.command-text) (attrValues config.bindings))}
        )
      '';
    };
  };

  hydraBind = {
    name,
    config,
    ...
  }: {
    options = {
      keybind = mkOption {
        type = types.str;
        default = name;
        description = ''
          Key to run this command on.
        '';
      };

      command = mkOption {
        type = types.str;
        description = ''
          Command to run.
        '';
      };

      name = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          Name to display for the command.
        '';
      };

      colour = mkOption {
        type = with types; nullOr (enum ["red" "blue"]);
        default = null;
        description = ''
          Colour for this command.
        '';
      };

      command-text = mkOption {
        type = types.str;
        visible = false;
        readOnly = true;
      };
    };

    config = {
      command-text = ''
        ("${config.keybind}" ${config.command} ${
          if config.name != null
          then "\"${config.name}\""
          else ""
        } ${
          if config.colour != null
          then ":color ${config.colour}"
          else ""
        })
      '';
    };
  };
in {
  options = {
    hydra = mkOption {
      type = with types; attrsOf (submodule hydraType);
      default = {};
      description = ''
        Attribute set defining hydras.
      '';
    };
  };

  config = mkIf (cfg != {}) {
    package.hydra.enable = true;
    postSetup = concatStringsSep "\n\n" (map (x: x.hydra-text) (attrValues cfg));
  };
}
