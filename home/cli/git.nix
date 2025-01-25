{ ... }: {
  programs.git = {
    enable = true;
    userName = "catboy009";
    userEmail = "catboy009@icloud.com";
    extraConfig = {
      github.user = "catboy009";
      init.defaultBranch = "main";
      difftool.prompt = false;
      mergetool = {
        keepBackup = false;
        trustExitCode = false;
        prompt = true;
      };
      diff = {
        tool = "vimdiff";
        guitool = "vimdiff";
      };
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
    };
  };
}
