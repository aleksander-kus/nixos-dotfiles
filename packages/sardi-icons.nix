{ lib, stdenv, fetchzip, breeze-icons, gtk3, gnome-icon-theme, hicolor-icon-theme, papirus-icon-theme, numix-icon-theme, numix-icon-theme-circle, moka-icon-theme }:

stdenv.mkDerivation rec {
    pname = "sardi-icons";
    version = "22.03-01";

    src = fetchzip rec {
        name = "${pname}-${version}";
        url = "https://downloads.sourceforge.net/project/sardi/${name}.tar.gz";
        sha256 = "IBiBRxyuCEwBs9R+tgVt5+gfM4PCtyBucjIYRmXo+7A=";
        stripRoot = false;
    };

    nativeBuildInputs = [ gtk3 ];

    propagatedBuildInputs = [
      breeze-icons
      gnome-icon-theme
      hicolor-icon-theme
      papirus-icon-theme
      numix-icon-theme
      numix-icon-theme-circle
      moka-icon-theme
    ];
    
    dontDropIconThemeCache = true;

    installPhase = ''
      mkdir -p $out/share/icons/
      cp -a * $out/share/icons/
      for theme in $out/share/icons/*; do
        gtk-update-icon-cache $theme
      done
    '';

    meta = with lib; {
        description = "Sardi-icons icon theme";
        homepage = "https://github.com/erikdubois/Sardi";
        platforms = platforms.linux;
    };
}