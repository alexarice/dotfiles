{
  melpaBuild,
  fetchFromGitHub,

  websocket,
}:
melpaBuild {
  pname = "typst-preview";
  version = "0-unstable-2024-10-24";

  packageRequires = [
    websocket
  ];

  src = fetchFromGitHub {
    owner = "havarddj";
    repo = "typst-preview.el";
    rev = "b7cbfb9403c445d4d60da97db3c027322cb70e4b";
    sha256 = "sha256-7iE9VxrnYptQtvvy6td++gY1Dl2DUUQXjKlWqEoxzSg=";
  };
}
