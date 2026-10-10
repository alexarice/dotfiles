{
  lib,
  epkgs,
  config,
  ...
}:
with lib; let
  packageOpts = {
    name,
    config,
    ...
  }: {
    options = {
      enable = mkEnableOption name;

      package = mkOption {
        type = with types; either package (listOf package);
        default = getAttr name epkgs;
        defaultText = literalExpression "epkgs.${name}";
        description = ''
          Nix package to install that provides ${name}. Can also be a list of packages to be installed, for example to include an optional dependency.
        '';
      };

      external-packages = mkOption {
        type = with types; listOf package;
        default = [];
        example = literalExpression "[ pkgs.silver-searcher ]";
        description = ''
          Packages that should be added to nixmacs' path.
        '';
      };

      priority = mkOption {
        type = types.int;
        default = 1000;
        example = 500;
        description = ''
          How early in the <filename>init.el</filename> the use-package declaration should appear.
        '';
      };

      name = mkOption {
        type = types.str;
        default = name;
        description = ''
          Package name to be used within <filename>init.el</filename>.
        '';
      };

      text = mkOption {
        type = types.str;
        description = ''
          Package initialisation text.
        '';
      };

      init = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:init</option> keyword of use-package.
        '';
      };

      config = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:config</option> keyword of use-package.
        '';
      };

      commands = mkOption {
        type = with types; either (listOf str) str;
        default = [];
        description = ''
          List of strings to be passed to <option>:commands</option> keyword of use-package.
        '';
      };

      bind = mkOption {
        type = types.bindType;
        default = {};
        description = ''
          Attribute set of bindings to be passed to <option>:bind</option> keyword of use-package.
        '';
      };

      mode = mkOption {
        type = types.str;
        default = "";
        description = ''
          String to be passed to the <option>:mode</option> keyword of use-package.
        '';
      };

      hook = mkOption {
        type = types.str;
        default = "";
        description = ''
          String to be passed to the <option>:hook</option> keyword of use-package.
        '';
      };

      custom = mkOption {
        type = types.varBindType;
        default = {};
        description = ''
          Attribute set to be passed to the <option>:custom</option> keyword of use-package.
        '';
      };

      custom-face = mkOption {
        type = types.varBindType;
        default = {};
        description = ''
          Attribute set to be passed to the <option>:custom-face</option> keyword of use-package.
        '';
      };

      demand = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Boolean to be passed to the <option>:demand</option> keyword of use-package.
        '';
      };

      after = mkOption {
        type = with types; either (listOf str) str;
        default = [];
        description = ''
          String to be passed to the <option>:after</option> keyword of use-package.
        '';
      };
    };
    config = {
      text = mkDefault (packageToConfig config);
    };
  };

  removeNonEmptyLines = s: builtins.concatStringsSep "\n" (builtins.filter (l: l != "") (splitString "\n" s));

  packageToConfig = p:
    removeNonEmptyLines ''
      (use-package ${p.name}
      ${
        if p.init != ""
        then ":init\n${p.init}"
        else ""
      }
      ${
        if p.config != ""
        then ":config\n${p.config}"
        else ""
      }
      ${
        if p.commands != []
        then ":commands (${builtins.concatStringsSep " " p.commands})"
        else ""
      }
      ${
        if p.bind != {}
        then ":bind\n${printBinding (p.bind)}"
        else ""
      }
      ${
        if p.mode != ""
        then ":mode ${p.mode}"
        else ""
      }
      ${
        if p.hook != ""
        then ":hook\n${p.hook}"
        else ""
      }
      ${
        if p.custom != {}
        then ":custom\n${printCustom p.custom}"
        else ""
      }
      ${
        if p.custom-face != {}
        then ":custom-face\n${printCustom p.custom-face}"
        else ""
      }
      ${
        if p.demand
        then ":demand t"
        else ""
      }
      ${
        if p.after != []
        then ":after (${builtins.concatStringsSep " " p.after})"
        else ""
      }
      )
    '';

  comparator = fst: snd: fst.priority < snd.priority || (fst.priority == snd.priority && fst.name < snd.name);
in {
  options = {
    package = mkOption {
      default = {};
      type = with types;
        submodule {
          freeformType = attrsOf (submodule packageOpts);
        };
      description = ''
        Package setup organised by package name.
      '';
    };
  };

  config = {
    rawPackageList =
      builtins.concatMap (p:
        if builtins.isList p.package
        then p.package
        else singleton p.package) (filter (p: p.enable) (builtins.attrValues (config.package)))
      ++ singleton epkgs.use-package;

    externalPackageList = builtins.concatMap (p: p.external-packages) (filter (p: p.enable) (builtins.attrValues (config.package)));

    preamble = mkBefore ''
      (setq user-init-file (or load-file-name (buffer-file-name)))

      (require 'use-package)
      (package-initialize)
      (require 'bind-key)
    '';

    packageSetup = builtins.concatStringsSep "\n\n" (map (x: x.text) (filter (p: p.enable) (builtins.sort comparator (builtins.attrValues (config.package)))));
  };
}
