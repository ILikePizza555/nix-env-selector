{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {self, nixpkgs, flake-utils, flake-compat}:
    flake-utils.lib.eachDefaultSystem (system: 
      let
        pkgs = import nixpkgs { inherit system; };
        commonPackages = [
          pkgs.nodejs-18_x
          pkgs.jdk17_headless
        ];
      in rec {
        devShells.default = pkgs.mkShell {
          buildInputs = commonPackages ++ [ pkgs.yarn ];
          postInstall = ''
            yarn install
          '';
        };
      }
    );
}
