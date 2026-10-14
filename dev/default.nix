{
  lib,
  inputs,
  ...
}: let
  files = builtins.readDir ./.;
  nixFiles =
    lib.filterAttrs (
      name: type: type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix"
    )
    files;
  importList = lib.mapAttrsToList (name: _: ./${name}) nixFiles;
in {
  imports = importList;
}
