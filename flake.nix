{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    gitignore = {
      url = "github:hercules-ci/gitignore.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, gitignore }: 
    flake-utils.lib.eachDefaultSystem (system: 
      let 
        pkgs = import nixpkgs { inherit system; };
	lib = nixpkgs.lib;

	name = "dj_transition";
	goBuild = pkgs.buildGoModule {
          inherit name;
	  src = ./.;
	  vendorSha256 = "sha256-MAkUGtP+Ms3a1PhLCr+2fR4IIx39sDNtlpKQURNIVF0=";
	};
      in
        {
          packages = {
            go = goBuild;
	  };
	  defaultPackage = goBuild;
	  devShell = pkgs.mkShell {
            packages = [ pkgs.gopls pkgs.go ];
	  };
	}
    );
}
