{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.dream2nix.url = "github:nix-community/dream2nix";
  inputs.dream2nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.src.url = "github:FichteFoll/discordrp-mpris";
  inputs.src.flake = false;

  outputs = inp:
    inp.dream2nix.lib.makeFlakeOutputs {
      systemsFromFile = ./nix_systems;
      config.projectRoot = ./.;
      source = inp.src;
    };
}
