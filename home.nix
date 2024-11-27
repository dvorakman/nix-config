{ config, pkgs, ... }:

{
  # Enable Home Manager to manage the user's environment
  home.username = "cardinal";  # The username

  # Set up environment variables
  home.sessionVariables = {
    EDITOR = "nano";  # Default editor
  };

  # User-specific packages to install
  home.packages = with pkgs; [
    git
    zsh
  ];

  # Configure the shell (e.g., zsh)
  programs.zsh.enable = true;
  programs.zsh.shellAliases = {
    ll = "ls -l";
    gs = "git status";
  };

  # Enable Home Manager's programs (like Firefox settings)
  programs.firefox.enable = true;
}