{lib}:
with lib; let
  wrapBrackets = x: "(${x})";
  inherit (builtins) isInt isFloat isString;
in {
  # Print a lispVarType to a string that lisp can recognise
  printLispVar = v: (
    if v == null
    then "nil"
    else if isInt v || isFloat v || isString v
    then toString v
    else if v
    then "t"
    else "nil"
  );

  # Print a varBindType to the format for the :custom keyword
  printCustom = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(${name} ${printLispVar value})") c);

  # Print a varBindType to a list of (setq x y)
  printVariables = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(setq ${name} ${printLispVar value})") c);

  # Print a varBindType to a list of (setq-default x y)
  printDefaultVariables = c:
    concatStringsSep "\n" (mapAttrsToList (name: value: "(setq-default ${name} ${printLispVar value})") c);

  # Print a map for bind key
  printBind = x: item: ''
    :map ${x}
    ${concatStringsSep "\n" (
      map (
        y: ''
          ("${y}" . ${getAttr y item})
        ''
      ) (attrNames item)
    )}'';

  # Print a bindType to the format for the :bind keyword
  printBinding = b: let
    items = attrNames b;
    sortedItems = sort (x: y: isString x && !(isString y)) items;
  in
    wrapBrackets (
      concatStringsSep "\n" (
        flip map sortedItems (
          x: let
            item = getAttr x b;
          in
            if isString item
            then "(\"${x}\" . ${item})"
            else printBind x item
        )
      )
    );
}
