{
  description = "say - a TTS CLI tool";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          say = pkgs.callPackage ./. { };
          default = say;
        };
      }
    ))
    // {
      overlays.default = final: prev: {
        say = self.packages.${prev.stdenv.hostPlatform.system}.default;
      };
    };
}
