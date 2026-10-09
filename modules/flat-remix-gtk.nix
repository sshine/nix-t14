{
  flake.nixosModules.flat-remix-gtk =
    { ... }:
    {
      # Dropped from nixpkgs along with gtk-engine-murrine, which only the theme's
      # unused GTK2 variant needs. Vendored without it to keep the GTK3 theme.
      nixpkgs.overlays = [
        (final: _prev: {
          flat-remix-gtk = final.stdenvNoCC.mkDerivation rec {
            pname = "flat-remix-gtk";
            version = "20240730";

            src = final.fetchFromGitHub {
              owner = "daniruiz";
              repo = "flat-remix-gtk";
              rev = version;
              hash = "sha256-EWe84bLG14RkCNbHp0S5FbUQ5/Ye/KbCk3gPTsGg9oQ=";
            };

            dontBuild = true;
            makeFlags = [ "PREFIX=$(out)" ];

            meta = {
              description = "Flat and remix GTK theme";
              homepage = "https://drasite.com/flat-remix-gtk";
              license = final.lib.licenses.gpl3Only;
              platforms = final.lib.platforms.all;
            };
          };
        })
      ];
    };
}
