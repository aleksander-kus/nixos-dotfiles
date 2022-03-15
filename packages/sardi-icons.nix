{ lib, stdenv, fetchzip, gtk3 }:

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

    installPhase = ''
      mkdir -p $out/share/icons/${pname}
      cp -r * $out/share/icons/${pname}/
      gtk-update-icon-cache $out/share/icons/${pname}/*
    '';

    meta = with lib; {
        description = "Sardi-icons icon theme";
        homepage = "https://github.com/erikdubois/Sardi";
        platform = platforms.linux;
    };
}