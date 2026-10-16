{lib}: {
  importFiles = dir: let
    files = builtins.readDir dir;
    nixFiles =
      lib.filterAttrs (
        name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
      )
      files;
  in
    lib.mapAttrsToList (name: _: dir + "/${name}") nixFiles;
}
