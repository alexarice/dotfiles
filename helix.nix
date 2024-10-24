{pkgs, ...}: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula";
      editor = {
        lsp.display-messages = true;
      };
      keys.normal = {
        "h" = "move_char_left";
        "n" = "move_char_right";
        "c" = "move_visual_line_up";
        "t" = "move_visual_line_down";
        "g" = "move_prev_word_start";
        "G" = "move_prev_long_word_start";
        "r" = "move_next_word_end";
        "R" = "move_next_long_word_end";
        "k" = "change_selection";
        "j" = "replace";
        "J" = "replace_with_yanked";
        "l" = "goto_line";
        "e" = "command_mode";
      };
      keys.select = {
        "h" = "extend_char_left";
        "n" = "extend_char_right";
        "c" = "extend_visual_line_up";
        "t" = "extend_visual_line_down";
        "g" = "extend_prev_word_start";
        "G" = "extend_prev_long_word_start";
        "r" = "extend_next_word_end";
        "R" = "extend_next_long_word_end";
        "k" = "change_selection";
        "j" = "replace";
        "J" = "replace_with_yanked";
        "l" = "goto_line";
        "e" = "command_mode";
      };
      keys.insert = {
        "menu" = "normal_mode";
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = false;
        formatter.command = "${pkgs.alejandra}";
      }
    ];
  };

  home.file."~/.config/helix/themes/dracula.toml".source = ./dracula.toml;
}
