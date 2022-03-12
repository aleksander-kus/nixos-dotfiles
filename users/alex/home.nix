{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  gtk = {
    enable = true;
    theme.name = "Arc-Dark";
    iconTheme.name = "Adwaita";
  };
  programs.xmobar.enable = true;
  services.network-manager-applet.enable = true;
  services.trayer = {
    enable = true;
    settings = {
      edge = "top";
      align = "right";
      SetDockType = true;
      SetPartialStrut = true;
      expand = true;
      widthtype = "request";
      height = 22;
      transparent = true;
      alpha = 0;
      padding = 6;
      monitor = 0;
      tint = "0x1e2127";
    };
  };
  services.picom = 
  {
    enable = true;
    inactiveOpacity = "0.8";
  };
  services.udiskie = 
  {
    enable = true;
    tray = "always";
  };

  services.redshift.enable = true;
  services.redshift.provider = "geoclue2";
  programs.alacritty.enable = true;
  programs.exa.enable = true;
  home.packages = with pkgs; [
    alacritty
    brave
    btop
    krusader
    onlyoffice-bin
    git
  ];
}
