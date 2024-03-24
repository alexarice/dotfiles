{ fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage {
  pname = "lspce-module";
  version = "master";

  src = fetchFromGitHub {
    owner = "zbelial";
    repo = "lspce";
    rev = "e2cf30a4148b355f0a8f960e6e8a71e12bbe3375";
    hash = "sha256-d3COHuUugXf8nMWdcgzAOFcdYy9Aa26bvm+qLQkE0Ic=";
  };

  doCheck = false;

  cargoHash = "sha256-/44rFjWF0J409xB+VHqaZBTzYKmKctbBjKznuOCWrHw=";
}
