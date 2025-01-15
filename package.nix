{ stdenv
, fetchurl
, ...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "506.0.0-0";
  sha256 = "e8528595ee2fc5e31a7f3415d470a6256da25911e6c6efc1e64cab7d09ac4727";
  md5sum = "a732f768ea189a818dc23ddcc3bc8185";
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