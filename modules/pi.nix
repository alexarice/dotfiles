{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.pi;
in {
  options.programs.pi = {
    enable = mkEnableOption "Pi coding agent configuration";

    # Settings.json structure
    settings = mkOption {
      type = types.submodule {
        options = {
          packages = mkOption {
            type = types.listOf (types.either types.path types.str);
            default = [];
            description = "List of pi packages as strings or paths to source directories";
          };

          editorPaddingX = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Editor horizontal padding";
          };

          terminal = mkOption {
            type = types.submodule {
              options = {
                hyperlinks = mkOption {
                  type = types.bool;
                  default = false;
                  description = "Enable terminal hyperlinks";
                };
              };
            };
            default = {};
            description = "Terminal settings";
          };
        };
      };
      default = {};
      description = "Pi settings.json configuration";
    };

    # Skills to install
    skills = mkOption {
      type = types.listOf types.path;
      default = [];
      description = "List of skill directories";
    };
  };

  config = mkIf cfg.enable {
    # Install pi-coding-agent and nodejs
    home.packages = [pkgs.pi-coding-agent pkgs.nodejs];

    # Create settings.json from structured options
    # Package derivations are converted to store paths
    home.file.".pi/agent/settings.json" = {
      text = builtins.toJSON cfg.settings;
    };

    # Deploy skills
    home.file.".pi/agent/skills" = mkIf (cfg.skills != []) {
      source = pkgs.runCommand "pi-skills" {} ''
        mkdir -p $out
        ${concatMapStringsSep "\n" (skill: ''
            cp -r ${skill} $out/$(basename ${skill})
          '')
          cfg.skills}
      '';
      recursive = true;
    };
  };
}
