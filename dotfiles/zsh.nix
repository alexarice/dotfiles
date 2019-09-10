{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      ignoreDups = true;
    };
    initExtra = ''
      export DEFAULT_USER=\"alex\"
      prompt_context(){}
      if [[ -z $DISPLAY ]] && [[ $(tty) =
      /dev/tty1 ]]; then
      exec ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway
      fi
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "fasd"
        "scala"
        "cabal"
        "extract"
        "systemd"
        "web-search"
      ];
      custom = "${pkgs.callPackage ./zsh_custom { }}";
      theme = "powerlevel10k";
    };
    sessionVariables = {
      EDITOR = "nixmacs";
      BROWSER = "firefox";
    };
  };
}
