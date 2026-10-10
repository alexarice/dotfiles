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

      defer = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Boolean to be passed to the <option>:defer</option> keyword of use-package.
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
        #TODO better description
        description = ''
          Attribute set of bindings to be passed to <option>:bind</option> keyword of use-package.
        '';
      };

      bind-keymap = mkOption {
        type = types.bindType;
        default = {};
        description = ''
          List of bindings to be passed to <option>:bind-keymap</option> keyword of use-package.
        '';
      };

      mode = mkOption {
        type = types.str;
        default = "";
        description = ''
          String to be passed to the <option>:mode</option> keyword of use-package.
        '';
      };

      interpreter = mkOption {
        type = types.str;
        default = "";
        description = ''
          String to be passed to the <option>:interpreter</option> keyword of use-package.
        '';
      };

      magic = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:magic</option> keyword of use-package.
        '';
      };

      magic-fallback = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:magic-fallback</option> keyword of use-package.
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

      if-keyword = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:if</option> keyword of use-package.
        '';
      };

      when = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:when</option> keyword of use-package.
        '';
      };

      unless = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:unless</option> keyword of use-package.
        '';
      };

      after = mkOption {
        type = with types; either (listOf str) str;
        default = [];
        description = ''
          String to be passed to the <option>:after</option> keyword of use-package.
        '';
      };

      defines = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:defines</option> keyword of use-package.
        '';
      };

      functions = mkOption {
        type = types.lines;
        default = "";
        description = ''
          String to be passed to the <option>:functions</option> keyword of use-package.
        '';
      };

      diminish = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          String to be passed to the <option>:diminish</option> keyword of use-package.
        '';
      };

      delight = mkOption {
        type = with types; nullOr str;
        default = null;
        description = ''
          String to be passed to the <option>:delight</option> keyword of use-package.
        '';
      };

      chords = mkOption {
        type = types.bindType;
        default = {};
        description = ''
          Attribute set to be passed to the <option>:chords</option> keyword of use-package.
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
        if p.defer
        then ":defer t"
        else ""
      }
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
        if p.bind-keymap != {}
        then ":bind-keymap\n${printBinding (p.bind-keymap)}"
        else ""
      }
      ${
        if p.mode != ""
        then ":mode ${p.mode}"
        else ""
      }
      ${
        if p.interpreter != ""
        then ":interpreter\n${p.interpreter}"
        else ""
      }
      ${
        if p.magic != ""
        then ":magic\n${p.magic}"
        else ""
      }
      ${
        if p.magic-fallback != ""
        then ":magic-fallback\n${p.magic-fallback}"
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
        if p.if-keyword != ""
        then ":if\n${p.if-keyword}"
        else ""
      }
      ${
        if p.when != ""
        then ":when\n${p.when}"
        else ""
      }
      ${
        if p.unless != ""
        then ":unless\n${p.unless}"
        else ""
      }
      ${
        if p.after != []
        then ":after (${builtins.concatStringsSep " " p.after})"
        else ""
      }
      ${
        if p.defines != ""
        then ":defines\n${p.defines}"
        else ""
      }
      ${
        if p.functions != ""
        then ":functions\n${p.functions}"
        else ""
      }
      ${
        if p.diminish != null
        then ":diminish\n${p.diminish}"
        else ""
      }
      ${
        if p.delight != null
        then ":delight\n${p.delight}"
        else ""
      }
      ${
        if p.chords != {}
        then ":chords\n${printBinding p.chords}"
        else ""
      }
      )
    '';

  comparator = fst: snd: fst.priority < snd.priority || (fst.priority == snd.priority && fst.name < snd.name);

  packages = attrValues config.package;
  useDiminish = any (x: x.diminish != null) packages;
  useDelight = any (x: x.delight != null) packages;
  useChords = any (x: x.chords != {}) packages;
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

    package = {
      use-package-chords = {
        enable = mkIf useChords true;
        priority = mkDefault 400;
      };
      diminish = {
        enable = mkIf useDiminish true;
        priority = mkDefault 400;
      };
      delight = {
        enable = mkIf useDelight true;
        priority = mkDefault 400;
      };
    };

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
