{ stdenv
, fetchurl
, ...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "507.0.0-0";
  sha256 = "e5cb88c8f91aa4a8ecbe07af55d4c15d0ae4319f9c8c5f2bae6f3851ac5b4639";
  md5sum = "595838cbc5c1e7c10aba2d5573b14a3d";
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