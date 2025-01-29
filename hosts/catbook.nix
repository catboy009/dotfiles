{ pkgs, lib, ... }: {
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      system = aarch64-darwin
      extra-platforms = aarch64-darwin
      experimental-features = nix-command flakes
      build-users-group = nixbld
      sandbox = true
    '';
  };
  programs.fish.enable = true;
  system.activationScripts.postActivation.text = ''
    sudo chsh -s ${lib.getBin pkgs.fish}/bin/fish catboy
  '';
  users.users.catboy.home = "/Users/catboy";

  networking = {
    hostName = "catbook";
    computerName = "catbook";
    localHostName = "catbook";
  };
  system.stateVersion = 4;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
    nonUS.remapTilde = true;
  };

  system.defaults = {
    screencapture = { location = "/tmp"; };
    dock = {
      showhidden = true;
      mru-spaces = false;
      minimize-to-application = true;
      show-recents = false;
      tilesize = 30;
      autohide = true;
    };
    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      FXDefaultSearchScope = "SCcf";
      CreateDesktop = false;
      AppleShowAllExtensions = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };
    NSGlobalDomain = {
      NSDocumentSaveNewDocumentsToCloud = false;
      NSTableViewDefaultSizeMode = 1;
      AppleKeyboardUIMode = 3;
      _HIHideMenuBar = true;
      InitialKeyRepeat = 10;
      KeyRepeat = 1;
    };
  };
}
