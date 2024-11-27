{ config, pkgs, ... }:

{
  home.username = "myuser";
  home.homeDirectory = "/home/myuser";

  programs.zsh.enable = true;
  programs.git.enable = true;

  programs.alacritty.enable = true;

  home.packages = with pkgs; [
    nano
    firefox
    zsh
    dmenu
  ];

  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor=,1920x1080@60,0x0,1
    input:kb_layout=dvorak
    exec-once=alacritty
  '';

  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -alF";
      gs = "git status";
    };
  };
}