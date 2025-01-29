{ pkgs, inputs, lib, ... }: {
  home.packages =
    [ pkgs.fishPlugins.autopair inputs.grc-rs.packages.${pkgs.system}.default ];
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format =
        "$directory$git_branch$git_commit$git_state$git_status$nix_shell$cmd_duration$line_break$character";
      nix_shell = {
        format = "via [ nix]($style) ";
        heuristic = true;
      };
      directory = {
        style = "cyan bold italic";
        read_only = " ";
      };
      character = {
        vimcmd_symbol = "[❯](bold blue)";
        vimcmd_visual_symbol = "[❯](bold purple)";
        vimcmd_replace_symbol = "[❯](bold yellow)";
        vimcmd_replace_one_symbol = "[❯](bold yellow)";
      };
      git_branch = {
        symbol = " ";
        format = "[$symbol$branch(:$remote_branch)]($style) ";
      };
    };
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ll = "${lib.getExe pkgs.eza} --icons -l -s type -a --git";
      ls = "${lib.getExe pkgs.eza} --icons -s type -a --git";
      tree = "${
          lib.getExe pkgs.eza
        } --icons -s type -a --git -T -I '.git|node_modules|.next'";
      top = "${lib.getExe pkgs.htop}";
      cp = "cp -r";
      rm = "rm -r";
      du = "grc-rs du -h";
      df = "grc-rs df -h";
      find = "fd";
      grep = "rg";
      copy = "pbcopy";
      ":q" = "exit";
      ":h" = "man";
      mkdir = "mkdir -p";
      nr = "darwin-rebuild switch --flake ~/.dotfiles#catbook";
      ipinfo = "curl -s ipinfo.io | xq";
      c = "clear";
      g = "git";
    };
    shellInit = ''
      set fish_greeting
      set -gx EDITOR (which nvim)
      set -gx VISUAL $EDITOR
      set -gx SUDO_EDITOR $EDITOR
      set -gx MANPAGER "nvim +Man!"
      set -gx PKG_CONFIG_PATH "${pkgs.openssl.dev}/lib/pkgconfig"
      set -gx PF_INFO "title os host kernel uptime pkgs memory"

      ${lib.getExe pkgs.nix-your-shell} fish | source
      grc-rs --aliases --except=du,df | source

      fish_vi_key_bindings

      set -g fish_vi_force_cursor
      set -g fish_cursor_default block
      set -g fish_cursor_insert line
      set -g fish_cursor_replace_one underscore
      set -g fish_cursor_visual block

      # make autocompletion work with gitconfig aliases 
      set -g __fish_git_alias_a add
      set -g __fish_git_alias_d diff
      set -g __fish_git_alias_co checkout
      set -g __fish_git_alias_cm commit
      set -g __fish_git_alias_ca commit
      set -g __fish_git_alias_ps push
      set -g __fish_git_alias_pl pull
      set -g __fish_git_alias_st status
      set -g __fish_git_alias_br branch
      set -g __fish_git_alias_ba branch
      set -g __fish_git_alias_bm branch
      set -g __fish_git_alias_bn branch
      set -g __fish_git_alias_lg log
      set -g __fish_git_alias_type cat-file
      set -g __fish_git_alias_dump cat-file
    '';
  };

  xdg.configFile."grc-rs" = {
    source = "${inputs.grc-rs.packages.${pkgs.system}.default}/etc/grc-rs";
    recursive = true;
  };
}
