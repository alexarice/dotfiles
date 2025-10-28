{...}: {
  programs = {
    git = {
      enable = true;
      ignores = ["*~"];
      signing = {
        key = "4B9FC04B9EE7F4AE99A7573493DDCD7A2B3F3B88";
        signByDefault = true;
      };
      lfs.enable = true;
      settings = {
        user = {
          name = "Alex Rice";
          email = "alexrice999@hotmail.co.uk";
        };
        core.filemode = false;
        pull.rebase = true;
        credential.helper = "store";
      };
    };

    gh = {
      enable = true;
      settings = {
        version = 1;
      };
    };
  };
}
