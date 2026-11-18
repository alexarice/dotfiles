{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.keymap;
in {
  options = {
    keymap = mkOption {
      type = with types; attrsOf (attrsOf str);
      default = {};
      description = ''
        Keybindings to put in new keymap
      '';
    };
  };

  config = {
    preamble = mkIf (cfg != {}) (concatStringsSep "\n" (map (x: ''
      (define-prefix-command '${x})
      (bind-keys ${printBind x (getAttr x cfg)})
    '') (attrNames cfg)));
  };
}
