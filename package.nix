{ stdenv
, fetchurl
, ...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "514.0.0-0";
  sha256 = "4cd488cb9ab8b4b48600f53d579c500cc835750451656e8e2efec9538fc3e93e";
  md5sum = "fb34ff59d220e2a2bc28e4c0a54b559b";
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