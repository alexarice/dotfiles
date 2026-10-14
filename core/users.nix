{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    # Sudo works on all hosts
    security.sudo = {
      enable = true;
      extraConfig = "Defaults pwfeedback";
    };

    # Immutable users only on non-WSL hosts
    users = lib.mkIf (config.machine != "wsl") {
      mutableUsers = false;
      users.root = {
        shell = pkgs.fish;
        hashedPassword = "$6$4dxSa3uVxuwa$2pkshyXLslXxhuZCMZVmrknXsrd4k5DTrJgoL4izv6U/XQJ6iM2asqX.L6chpmEiBlhJC1F1P7Pw/3RZX/VMN0";
      };
      users.alex = {
        shell = pkgs.fish;
        isNormalUser = true;
        home = "/home/alex";
        extraGroups = ["wheel" "networkmanager" "video" "audio"];
        uid = 1000;
        hashedPassword = "$6$lY0U5C4WoOcmj.6$YLKJMkQVUJDbItcyHV7wZuvmzpvmOcPR9dgHWJYzUHBB7bSevyC4Vqpqm2IxoVqqhpz.KY7aQJnQI2HaSDsL1.";
      };
    };

    services.getty.autologinUser = lib.mkIf (config.machine != "wsl") "alex";
  };
}
