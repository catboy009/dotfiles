{ pkgs, inputs, config, ... }: {
  imports = [
    ./cli/git.nix
    ./cli/fish.nix
    ./cli/neovim.nix
    ./cli/himalaya.nix

    ./desktop/gtk.nix
    ./desktop/sway.nix
    ./desktop/dunst.nix
  ];
  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    wezterm
    firefox
    ripgrep
    pfetch-rs
    rink
    thokr
    fd
    xq
    nodejs
    bun
    tlrc
    theme
    # rust dev
    rustup
    pkg-config
    gnumake
    lld_19
    gcc
  ];
  xdg.configFile."wezterm" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/home/catboy/.dotfiles/configs/wezterm";
    recursive = true;
  };
  xdg.configFile."luakit" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/home/catboy/.dotfiles/configs/luakit";
    recursive = true;
  };
}
