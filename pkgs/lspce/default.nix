{ callPackage, trivialBuild, yasnippet, markdown-mode, f }:

let module = callPackage ./module.nix { };
in trivialBuild {
  pname = "lspce";
  version = "master";

  src = module.src;

  buildInputs = [
    yasnippet
    markdown-mode
    f
  ];

  preBuild = ''
    cp ${module}/lib/liblspce_module.so lspce-module.so
  '';

  postInstall = ''
    install *.so $LISPDIR
  '';
}
