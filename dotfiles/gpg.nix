{ ... }:

{
  gpg = {
    enable = true;
    settings = {
      default-cache-ttl = 360000;
      max-cache-ttl = 360000;
    };
  };
}
