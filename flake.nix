{
  description = "Atlassian Teamwork Graph CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      version = "1.4.5";
      twg = pkgs.stdenvNoCC.mkDerivation {
        pname = "twg";
        inherit version;

        src = pkgs.fetchurl {
          url = "https://teamwork-graph.atlassian.com/cli/twg-darwin-arm64-v${version}";
          hash = "sha256-lQE0Q82rDsClMMnKRRb42fqfldtXg9dltlBcTW6QQ88=";
        };

        dontUnpack = true;

        installPhase = ''
          install -Dm755 "$src" "$out/bin/twg"
        '';

        meta = {
          description = "Atlassian Teamwork Graph CLI";
          homepage = "https://teamworkgraph.com/cli";
          mainProgram = "twg";
        };
      };
    in
    {
      packages.aarch64-darwin = {
        inherit twg;
        default = twg;
      };

      overlays.aarch64-darwin = final: prev: {
        inherit twg;
      };
    };
}
