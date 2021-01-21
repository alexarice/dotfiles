{
  description = "A very basic flake";

  outputs = { self, nixpkgs }: {
    nixosModules.common = {
      imports = [ ./common.nix ];
    };
  };
}
