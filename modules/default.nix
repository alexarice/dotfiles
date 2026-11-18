{lib, ...}: let
  entries = builtins.readDir ./.;

  # Filter to .nix files (excluding default.nix) and directories with default.nix
  importable =
    lib.filterAttrs (
      name: type:
        if type == "regular"
        then lib.hasSuffix ".nix" name && name != "default.nix"
        else builtins.pathExists (./. + "/${name}/default.nix")
    )
    entries;
in {
  imports = lib.mapAttrsToList (name: _: ./. + "/${name}") importable;
}
