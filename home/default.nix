{ pkgs, lib, config, ... }: {
  imports = [ ./cli/git.nix ./cli/fish.nix ./cli/neovim.nix ];
  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    wezterm
    iina
    keka
    ripgrep
    pfetch-rs
    thokr
    fd
    xq
    nodejs
    bun
    tlrc
    # rust dev
    rustup
    pkg-config
    gnumake
    lld_19
  ];
  disabledModules = [ "targets/darwin/linkapps.nix" ];
  home.activation = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="/Applications/Nix"
      if [ -d "$baseDir" ]; then
        rm -rf "$baseDir"
      fi
      mkdir -p "$baseDir"
      for appFile in ${apps}/Applications/*; do
        target="$baseDir/$(basename "$appFile")"
        $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
        $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      done
    '';
  };
  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/Users/catboy/.dotfiles/configs/wezterm";
    recursive = true;
  };
  xdg.configFile."luakit" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/Users/catboy/.dotfiles/configs/luakit";
    recursive = true;
  };
}
