{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.dream2nix.url = "github:nix-community/dream2nix";
  inputs.dream2nix.inputs.nixpkgs.follows = "nixpkgs";
  inputs.src.url = "github:FichteFoll/discordrp-mpris";
  inputs.src.flake = false;

  outputs = inp: let
    system = "x86_64-linux";
    pkgs = inp.nixpkgs.legacyPackages.${system};
  in
    inp.dream2nix.lib.makeFlakeOutputs {
      systems = [system];
      config.projectRoot = ./.;
      source = inp.src;
      packageOverrides = {
        main.add-lib.overrideAttrs = old: {
          nativeBuildInputs = old.nativeBuildInputs ++ [pkgs.makeWrapper];
          postInstall = ''
            ${old.postInstall or ""}
            wrapProgram $out/bin/discordrp-mpris \
              --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [pkgs.dbus]}"
          '';
        };
      };
    };
}
