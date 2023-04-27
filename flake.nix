{
  description = "gke-gcloud-auth-plugin";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachSystem [ utils.lib.system.x86_64-linux ] (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        defaultPackage = import ./package.nix pkgs;
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            mustache-go
            sd
            yq
          ];
        };
      }
    );
}