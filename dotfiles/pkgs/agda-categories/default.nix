{ lib, mkDerivation, fetchFromGitHub, standard-library }:

mkDerivation rec {
  version = "0.1";
  pname = "agda-categories";

  src = ../../../agda-categories;

  buildInputs = [ standard-library ];

  meta = with lib; {
    inherit (src.meta) homepage;
    description = "A new Categories library";
    license = licenses.bsd3;
    platforms = platforms.unix;
    # agda categories takes a lot of memory to build.
    # This can be removed if this is eventually fixed upstream.
    hydraPlatforms = [];
    maintainers = with maintainers; [ alexarice ];
  };
}
