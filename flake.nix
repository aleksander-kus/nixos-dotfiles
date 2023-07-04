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
      localOverlay = self: super: {
        picom-jonaburg = super.picom.overrideAttrs (old: {
          src = super.fetchFromGitHub {
            owner = "jonaburg";
            repo = "picom";
            rev = "e3c19cd7d1108d114552267f302548c113278d45";
            sha256 = "R+YUGBrLst6CpUgG9VCwaZ+LiBSDWTp0TLt1Ou4xmpQ=";
          };
        });
        sardi-icons = super.callPackage ./packages/sardi-icons.nix {};
        #udiskie = super.callPackage ./packages/udiskie.nix {python = nixpkgs.legacyPackages.x86_64-linux.python310Packages;};
      };
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ 
          localOverlay 
          #./packages/default.nix
        ];
      };
  in
  {
    defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
    homeConfigurations = {
      alex = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/alex/home.nix ];
        # inherit system pkgs;
        # extraSpecialArgs = {inherit inputs self pkgs;};
        # username = "alex";
        # homeDirectory = "/home/alex";
        # configuration = ./users/alex/home.nix;
        # stateVersion = "23.05";
      };
    };

    nixosConfigurations = {
      ryszard-bis = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./system/configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
        specialArgs = { inherit inputs pkgs; };
      };
    };
  };
}
