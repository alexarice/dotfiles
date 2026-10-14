{
  lib,
  inputs,
  ...
}: let
  files = builtins.readDir ./.;
  importable =
    lib.filterAttrs (
      name: type:
        (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
        || (type == "directory")
    )
    files;
  importList = lib.mapAttrsToList (name: _: ./${name}) importable;
in {
  imports = importList;
}
