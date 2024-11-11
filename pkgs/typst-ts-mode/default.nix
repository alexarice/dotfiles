{melpaBuild}:
melpaBuild {
  pname = "typst-ts-mode";
  version = "0-unstable-2024-10-23";

  src = fetchGit {
    url = "https://codeberg.org/meow_king/typst-ts-mode";
    rev = "42094eb2508f30ca2aba26786768e969476d98fa";
  };
}
