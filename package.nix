{ stdenv
, fetchurl
, ...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "499.0.0-0";
  sha256 = "88c9c619ea373018bf11590fd7a250f7ef1d856118c5109555c5c10d22f40edc";
  md5sum = "ac64207e23a9606214f3e90786cb29f7";
  arch = "amd64";

  # get updates from here:
  # https://packages.cloud.google.com/apt/dists/cloud-sdk/main/binary-amd64/Packages
  src = fetchurl {
    url = "https://packages.cloud.google.com/apt/pool/cloud-sdk/google-cloud-cli-gke-gcloud-auth-plugin_${version}_${arch}_${md5sum}.deb";
    sha256 = sha256;
  };

  unpackPhase = ''
    cp $src $TMP/${pname}.deb
    ar vx ${pname}.deb
    mkdir -p $TMP/${pname}
    tar --no-overwrite-dir -xvf data.tar.xz -C $TMP/${pname}/
  '';

  installPhase = ''
    mkdir -p $out
    cp -R $TMP/${pname}/usr/* $out
  '';
}