{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.sauce-code-pro
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      roboto
      font-awesome
      freefont_ttf
      symbola
      dejavu_fonts
      fira
      source-sans
    ];
    enableDefaultPackages = false;

    fontconfig = {
      enable = true;
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = ["Hack Nerd Font"];
        sansSerif = ["DejaVu Sans"];
        serif = ["DejaVu Serif"];
      };
    };
  };
}
