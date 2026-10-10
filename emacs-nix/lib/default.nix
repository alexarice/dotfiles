{lib}:
lib.extend (lib: oldLib: let
  inherit (builtins) functionArgs intersectAttrs;
  callLib = file: let
    f = import file;
    args = functionArgs f;
  in
    f (intersectAttrs args {inherit oldLib lib;});
in rec {
  types = oldLib.types // (callLib ./types.nix);
  printers = callLib ./printers.nix;

  inherit (printers) printLispVar printCustom printVariables printDefaultVariables printBinding printBind;
})
