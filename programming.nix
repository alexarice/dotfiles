{
  pkgs,
  inputs,
  ...
}: {
  config = {
    overlays = [
      inputs.all-agda.overlay."x86_64-linux"
      (self: super: {
        agdaPackages = self.agdaPackages-2_8_0;
        agda = self.agda-2_8_0;
      })
    ];

    hm.home.packages = with pkgs; [
      # Haskell
      cabal-install

      # Agda
      (agda.withPackages (p: with p; [standard-library]))

      # Lean
      elan

      # Python
      python314
      uv

      # Rust
      cargo
      rustc
      wasm-pack
      rustfmt
      clippy

      # C/C++
      gnumake
      gdb
      lldb
      lld
      cmake
      ccache
      clang
      ninja
    ];
  };
}
