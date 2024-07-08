{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" "FiraCode" "DroidSansMono" ]; })

      anonymousPro
      dejavu_fonts
      emojione
      fira
      fira-code
      fira-code-symbols
      fira-mono
      freefont_ttf
      gentium
      hack-font
      inconsolata
      iosevka
      liberation_ttf
      lmodern
      montserrat
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      noto-fonts-extra
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family

      # unfree
      # corefonts
      # vistafonts
      # google-fonts
      # symbola
    ];
  };
}
