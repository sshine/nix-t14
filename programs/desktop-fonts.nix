{
  config,
  pkgs,
  ...
}: {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs.nerd-fonts; [
      _0xproto
      departure-mono
      iosevka
      droid-sans-mono
      iosevka-term
      profont
      agave
      envy-code-r
      iosevka-term-slab
      proggy-clean-tt
      anonymice
      fantasque-sans-mono
      jetbrains-mono
      arimo
      fira-code
      lekton
      recursive-mono
      aurulent-sans-mono
      fira-mono
      liberation
      roboto-mono
      bigblue-terminal
      geist-mono
      lilex
      sauce-code-pro
      bitstream-vera-sans-mono
      go-mono
      martian-mono
      shure-tech-mono
      blex-mono
      gohufont
      meslo-lg
      space-mono
      caskaydia-cove
      hack
      monaspace
      symbols-only
      caskaydia-mono
      hasklug
      monofur
      terminess-ttf
      code-new-roman
      heavy-data
      monoid
      tinos
      comic-shanns-mono
      hurmit
      mononoki
      ubuntu
      commit-mono
      im-writing
      # mplus
      ubuntu-mono
      cousine
      inconsolata
      noto
      ubuntu-sans
      d2coding
      inconsolata-go
      open-dyslexic
      victor-mono
      daddy-time-mono
      inconsolata-lgc
      overpass
      zed-mono
      dejavu-sans-mono
      intone-mono
    ];
  };
}
