{config, ...}: {
  # NixOS-level git configuration (system-wide)
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        name = "Alex Rice";
        email = "alexrice999@hotmail.co.uk";
      };
      core.filemode = false;
      pull.rebase = true;
      credential.helper = "store";
    };
  };

  # Home Manager level git configuration (user-specific)
  hm.programs.git = {
    ignores = ["*~"];
    signing = {
      key = "4B9FC04B9EE7F4AE99A7573493DDCD7A2B3F3B88";
      format = "openpgp";
      signByDefault = config.machine != "wsl";
    };
  };

  # GitHub CLI (HM only - no NixOS module)
  hm.programs.gh = {
    enable = true;
    settings = {
      version = 1;
    };
  };
}
