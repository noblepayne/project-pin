{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux"];
    pkgsBySystem = nixpkgs.lib.getAttrs supportedSystems nixpkgs.legacyPackages;
    forAllPkgs = fn: nixpkgs.lib.mapAttrs (system: pkgs: (fn pkgs)) pkgsBySystem;
  in {
    formatter = forAllPkgs (pkgs: pkgs.alejandra);
  };
}
