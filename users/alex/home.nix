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
    iconTheme.name = "Arc";
  };
  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };
  home.file.".config/Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=KvArcDark
  '';
  home.file.".config/qt5ct/qt5ct.conf".text = ''
    [Appearance]
    style=kvantum
    icon_theme=Arc
  '';
  home.file.".config/xmobar/xmobarrc".source = ./xmobar/xmobarrc;
  home.file.".config/xmobar/doom-one-xmobarrc".source = ./xmobar/doom-one-xmobarrc;
  home.file.".config/xmobar/trayer-padding-icon.sh" = 
  {
    source = ./xmobar/trayer-padding-icon.sh;
    executable = true;
  };
  home.file.".config/xmobar/haskell_20.xpm".source = ./xmobar/haskell_20.xpm;
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window = {
      padding = {
        x = 6;
        y = 6;
      };
      title = "Alacritty";
      class = {
        instance = "Alacritty";
        general = "Alacritty";
      };
      opacity = 0.75;
    };
    scrolling.history = 5000;
    font = {
      normal = {
        family = "MesloLGS Nerd Font Mono";
        style = "Regular";
      };
      bold = {
        family = "MesloLGS Nerd Font Mono";
        style = "Bold";
      };
      italic = {
        family = "MesloLGS Nerd Font Mono";
        style = "Bold";
      };
      bold_italic = {
        family = "MesloLGS Nerd Font Mono";
        style = "Bold Italic";
      };
      size = 11.0;
      offset = {
        x = 0;
        y = 1;
      };
    };
    colors = {
      primary = {
        background = "0x282c34";
        foreground = "0xbbc2cf";
      };
      selection = {
        text =       "0xbbc2cf";
        background = "0x3071db";
      };
      normal = {
        black =   "0x1c1f24";
        red =     "0xff6c6b";
        green =   "0x98be65";
        yellow =  "0xda8548";
        blue =    "0x51afef";
        magenta = "0xc678dd";
        cyan =    "0x5699af";
        white =   "0x202328";
      };
      bright = {
        black =   "0x5b6268";
        red =     "0xda8548";
        green =   "0x4db5bd";
        yellow =  "0xecbe7b";
        blue =    "0x3071db";
        magenta = "0xa9a1e1";
        cyan =    "0x46d9ff";
        white =   "0xdfdfdf";
      };
    };
  };
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
  programs.exa.enable = true;
  home.packages = with pkgs; [
    brave
    btop
    krusader
    onlyoffice-bin
    git
    neofetch
    nitrogen
    xdotool
    volumeicon
    dconf
    arc-theme
    arc-icon-theme
    pavucontrol
    libsForQt5.qtstyleplugin-kvantum
    xmobar
  ];

  xsession = {
    enable = true;
    initExtra = ''
    ${pkgs.nitrogen}/bin/nitrogen --restore &
    ${pkgs.pavucontrol}/bin/pavucontrol &
    ${pkgs.volumeicon}/bin/volumeicon &
    xsetroot -cursor_name left_ptr
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
