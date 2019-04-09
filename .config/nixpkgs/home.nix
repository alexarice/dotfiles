{pkgs, lib, ...}:

let
  dots = "/home/alex/dotfiles";
  scripts = "/home/alex/scripts";
  i3mod = "Mod4";
in
{
  programs = {
    git = {
      enable = true;
      userName = "Alex Rice";
      userEmail = "alexrice999@hotmail.co.uk";
      ignores = ["*~"];
      extraConfig = ''
                    [core]
                      filemode = false
                    '';
    };
    termite = {
      enable = true;
      allowBold = true;
      audibleBell = false;
      clickableUrl = true;
      dynamicTitle = true;
      filterUnmatchedUrls = true;
      fullscreen = false;
      scrollOnOutput = false;
      scrollOnKeystroke = true;
      scrollbackLines = 10000;
      searchWrap = false;
      urgentOnBell = true;
      font = "Source Code Pro for Powerline 10";
      cursorBlink = "system";
      cursorColor = "#81c1e4";
      cursorForegroundColor = "#81c1e4";
      cursorShape = "block";
      backgroundColor = "rgba(40,42,54,0.6)";
      foregroundColor = "#f8f8f2";
      foregroundBoldColor = "#f8f8f2";
      highlightColor = "#ccccc7";
      colorsExtra = ''
        color0 = #000000
        color1 = #ff5555
        color2 = #50fa7b
        color3 = #f1fa8c
        color4 = #bd93f9
        color5 = #ff79c6
        color6 = #8be9fd
        color7 = #bbbbbb
        color8 = #555555
        color9 = #ff5555
        color10 = #50fa7b
        color11 = #f1fa8c
        color12 = #bd93f9
        color13 = #ff79c6
        color14 = #8be9fd
        color15 = #ffffff
        '';
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      history = {
        ignoreDups = true;
      };
      initExtra = ''
                export DEFAULT_USER=\"alex\"
                prompt_context(){}
                if [[ -z $DISPLAY ]] && [[ $(tty) =
                /dev/tty1 ]]; then
                  exec sway
                fi
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
        theme = "agnoster";
      };
    };
  };
  gtk = {
    enable = true;
    theme = {
      package = pkgs.adapta-gtk-theme;
      name = "Adapta-Nokto-Eta";
    };
    iconTheme = {
      package = pkgs.gnome3.adwaita-icon-theme;
      name = "Adwaita";
    };
    font = {
      package = pkgs.source-code-pro;
      name = "Source Code Pro 10";
    };
    gtk3.extraConfig = {
      gtk-cursor-theme-size=0;
      gtk-toolbar-style="GTK_TOOLBAR_BOTH";
      gtk-toolbar-icon-size="GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-button-images=1;
      gtk-menu-images=1;
      gtk-enable-event-sounds=1;
      gtk-enable-input-feedback-sounds=1;
      gtk-xft-antialias=1;
      gtk-xft-hinting=1;
      gtk-xft-hintstyle="hintslight";
      gtk-xft-rgba="rgb";
    };
  };
  home.file.".spacemacs".source = "${dots}/spacemacs";
  home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
  home.file.".config/waybar/config".source = "${dots}/waybar";
  home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
  home.file.".config/sway/config".source = "${dots}/sway";
}
