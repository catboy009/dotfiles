{ pkgs, ... }: {
  programs.fish.enable = true;
  users.users.catboy = {
    isNormalUser = true;
    home = "/home/catboy";
    extraGroups = [ "wheel" "audio" "video" "render" "input" ];
    shell = pkgs.fish;
  };
}
