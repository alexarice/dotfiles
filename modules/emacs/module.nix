{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  ecfg = config.programs.emacs;

  emacsConfig = types.submoduleWith {
    description = "Emacs nix module";
    specialArgs = {
      hmConfig = config;
      epkgs = ecfg.package.pkgs;
      lib = pkgs.callPackage ./lib {};
    };

    modules = [
      ./modules/base.nix
      ./modules/keymap.nix
      ./modules/hydra.nix
      ./modules/package.nix
      ./modules/tree-sitter.nix
      ./modules/settings.nix
    ];
  };
in {
  options.programs.emacs.config = mkOption {
    type = emacsConfig;
    default = {...}: {};
  };

  config = {
    programs.emacs = mkIf ecfg.enable {
      extraConfig = ecfg.config.configFile;
      extraPackages = _epkgs: ecfg.config.rawPackageList;
    };

    home.packages = ecfg.config.externalPackageList;
  };
}
