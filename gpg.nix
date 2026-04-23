{pkgs, ...}: {
  hm.services.gpg-agent.enable = true;

  hm.home.packages = with pkgs; [gnupg];
}
