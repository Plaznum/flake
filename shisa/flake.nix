{
  description = "pandy nixos flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ...} @ inputs: let in {
    nixosConfigurations.shisa = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./nixos/configuration.nix ];
    };
    #homeConfigurations = {
    #  "pandy@shisa" = home-manager.lib.homeManagerConfiguration {
    #    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #    extraSpecialArgs = {inherit inputs;};
    #    modules = [./home-manager/home.nix];
    #  };
    #};
  };
}
