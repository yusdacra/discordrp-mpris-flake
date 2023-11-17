{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.dream2nix.url = "github:nix-community/dream2nix";
  inputs.dream2nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.src.url = "github:SergSel2006/discordrp-mpris-albumart";
  inputs.src.flake = false;

  outputs = inp: let
    system = "x86_64-linux";
    pkgs = inp.nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = inp.dream2nix.lib.evalModules {
      packageSets.nixpkgs = pkgs;
      modules = [
        {mkDerivation.src = inp.src;}
        ./default.nix
        {
          paths.projectRoot = ./.;
          paths.projectRootFile = "flake.nix";
          paths.package = ./.;
        }
      ];
    };
  };
}
