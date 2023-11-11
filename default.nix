{
  config,
  lib,
  dream2nix,
  ...
}: let
  pipfile = lib.importTOML (config.mkDerivation.src + /Pipfile);
in {
  imports = [
    dream2nix.modules.dream2nix.pip
  ];

  deps = {nixpkgs, ...}: {
    inherit
      (nixpkgs)
      dbus
      makeWrapper
      ;
  };

  name = "discordrp-mpris";
  version = "0.3.3";

  mkDerivation = {
    nativeBuildInputs = [config.deps.makeWrapper];
    postFixup = ''
      wrapProgram $out/bin/discordrp-mpris \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [config.deps.dbus]}"
    '';
  };

  buildPythonPackage = {
    pythonImportsCheck = [
      "discordrp_mpris"
    ];
  };

  pip = {
    requirementsList = builtins.attrNames pipfile.packages;
    flattenDependencies = true;
  };
}
