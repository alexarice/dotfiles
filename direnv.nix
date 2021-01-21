{ ... }:

{
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableFishIntegration = true;
  };
}
