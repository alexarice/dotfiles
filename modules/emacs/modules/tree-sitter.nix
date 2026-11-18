{
  config,
  lib,
  epkgs,
  ...
}:
with lib; let
  cfg = config.tree-sitter;
  ts = epkgs.treesit-grammars;
in {
  options = {
    tree-sitter = {
      enable = mkEnableOption "tree-sitter";
      grammars = mkOption {
        type = with types; nullOr (functionTo (listOf package));
        default = null;
        description = ''
          Grammars to include (include all grammars when null)
        '';
      };
    };
  };

  config = {
    rawPackageList = mkIf cfg.enable (lib.singleton (
      if cfg.grammars != null
      then ts.with-grammars cfg.grammars
      else ts.with-all-grammars
    ));
  };
}
