{ stdenv
, fetchurl
, ...
}:

stdenv.mkDerivation rec {
  pname = "gke-gcloud-auth-plugin";
  version = "508.0.0-0";
  sha256 = "024500d40a07d11d25fea5a6dcd5005f648bad40a96ced8752c7e75981be0236";
  md5sum = "a50fc279ee479914d37a4cd41fb0fef0";
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