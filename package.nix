{ stdenv
, fetchurl
, autoPatchelfHook,
...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "393.0.0";

  src = fetchurl {
    url = "https://packages.cloud.google.com/apt/pool/google-cloud-cli-gke-gcloud-auth-plugin_${version}-0_amd64_04cca5f6ba7035954886226c519fa3627f97750bb664371b3def0864d6889e92.deb";
    sha256 = "sha256-BMyl9rpwNZVIhiJsUZ+jYn+XdQu2ZDcbPe8IZNaInpI=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  unpackPhase = ''
    cp $src $TMP/${pname}.deb
    ar vx ${pname}.deb
    mkdir -p $TMP/${pname}
    tar --no-overwrite-dir -xvf data.tar.xz -C $TMP/${pname}/
    ls $TMP/${pname}/usr
  '';

  installPhase = ''
    mkdir -p $out
    cp -R $TMP/${pname}/usr/* $out
  '';
}