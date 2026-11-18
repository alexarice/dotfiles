{lib}:
with lib; rec {
  bindType = with types;
    attrsOf (either str (attrsOf str))
    // {
      description = ''
        attribute set of strings or a nested attribute set of strings
      '';
    };

  varBindType = with types; attrsOf lispVarType;

  lispVarType = with types;
    nullOr (oneOf [int float bool str])
    // {
      description = ''
        int, float, bool, string, or null to represent a value in elisp
      '';
    };
}
