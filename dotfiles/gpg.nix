{ lib, ... }:

with lib;

{
  services.gpg-agent.enable = true;
}
