{
  inputs.dream2nix.url = "github:nix-community/dream2nix";
  inputs.src.url = "github:FichteFoll/discordrp-mpris";
  inputs.src.flake = false;

  outputs = inp:
    inp.dream2nix.lib.makeFlakeOutputs {
      systemsFromFile = ./nix_systems;
      config.projectRoot = ./.;
      source = inp.src;
    };
}
