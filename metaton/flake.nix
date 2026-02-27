{
  description = "pandy nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.metaton = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/configuration.nix ];
    };
    homeConfigurations."pandy" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/home.nix
        ./home-manager/neovim.nix
        ./home-manager/sway.nix
      ];
    };
  };
}
