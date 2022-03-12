{
  description = "A very basic config";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixpkgs, home-manager} @inputs: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
  in
  {
    homeConfigurations = {
      alex = inputs.home-manager.lib.homeManagerConfiguration {
        inherit system;
        extraSpecialArgs = {inherit inputs self pkgs;};
        username = "alex";
        homeDirectory = "/home/alex";
        configuration = ./users/alex/home.nix;
        stateVersion = "22.05";
      };
    };

    nixosConfigurations = {
      mysystem = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./system/configuration.nix ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
