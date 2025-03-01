{ inputs, colors, ... }: {
  imports = [
    ./console.nix
    ./networking.nix
    ./users.nix
    ./locale.nix
    ./environment.nix
    ./bluetooth.nix
    ./printing.nix
  ];
  nixpkgs.overlays = [ (import ../../overlays/binscripts.nix) ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs colors; };
    users.catboy.imports = [ ../../home ];
  };
  nix = {
    gc.automatic = true;
    settings = {
      warn-dirty = false;
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      tarball-ttl = 604800;
    };
  };
  nixpkgs.config.allowUnfree = true;

  security.sudo.wheelNeedsPassword = false;

  services = {
    logind.powerKey = "ignore";
    upower.enable = true;
    fstrim.enable = true;
    timesyncd.enable = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    timeout = 0;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  programs.dconf.enable = true;
}
