{
  description = "say - a TTS CLI tool";

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          say = pkgs.callPackage ./. { };
          default = say;
        };
      });
}
