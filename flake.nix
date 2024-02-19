{
  description = "Description";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
        devTools = with pkgs; [
          bashInteractive

          texliveFull

          jupyter-all
          python311Packages.pandas
          python311Packages.numpy
          python311Packages.matplotlib
        ];
      in {
        devShell = pkgs.mkShell ({
          buildInputs = devTools;
          FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories = [ pkgs.corefonts pkgs.stix-two ]; };
        });
      }
    );
}
