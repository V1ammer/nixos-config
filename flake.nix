{
  description = "not a very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    battery-notifier = {
      url = "github:V1ammer/battery-notifier/fix-battery-id-selector";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdp-termfilepickers = {
      url = "github:Guekka/xdg-desktop-portal-termfilepickers";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # catppuccin = {
    #   url = "github:catppuccin/nix/release-25.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.noctalia-qs.follows = "noctalia-qs";
    # };
    # noctalia-qs = {
    #   url = "github:noctalia-dev/noctalia-qs";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
    homeConfigurations.killua = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home-manager/home.nix
      ];
      extraSpecialArgs = {inherit inputs;};
    };
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [nil nixd];
    };
  };
}
