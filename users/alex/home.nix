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
    iconTheme.name = "Sardi-Arc";
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
    icon_theme=Sardi-Arc
  '';
  home.file.".config/btop/btop.conf".text = "theme_background = False";
  home.file.".config/xmobar/xmobarrc".source = ./xmobar/xmobarrc;
  home.file.".config/xmobar/doom-one-xmobarrc".source = ./xmobar/doom-one-xmobarrc;
  home.file.".config/xmobar/trayer-padding-icon.sh" = 
  {
    source = ./xmobar/trayer-padding-icon.sh;
    executable = true;
  };
  home.file.".config/xmobar/haskell_20.xpm".source = ./xmobar/haskell_20.xpm;
  #home.file.".config/fish/config.fish".source = ./config.fish;
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env.TERM = "xterm-256color";
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
        family = "MesloLGS NF";
        style = "Regular";
      };
      bold = {
        family = "MesloLGS NF";
        style = "Bold";
      };
      italic = {
        family = "MesloLGS NF";
        style = "Bold";
      };
      bold_italic = {
        family = "MesloLGS NF";
        style = "Bold Italic";
      };
      size = 11.0;
      offset = {
        x = 0;
        y = 1;
      };
    };
    draw_bold_text_with_bright_colors = true;
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
    package = pkgs.picom-jonaburg;
    shadow = false;
    fade = false;
    #fadeSteps = [ "0.09" "0.09" ];
    inactiveOpacity = "0.8";
    activeOpacity = "0.9";
    menuOpacity = "0.8";
    opacityRule = [
      "75:name *?= 'xmobar'"
      "80:class_g *?= 'Steam'"
    ];
    blur = true;
    blurExclude = [
      "class_g = 'Alacritty'"
      "class_g = 'Code'"
      "name *?= 'xmobar'"
    ];
    #experimentalBackends = true;
    #vSync = true;
    extraOptions = ''
     mark-wmwin-focused = true;
     mark-ovredir-focused = false;
     detect-client-opacity = true;
     corner-radius = 10.0;
     round-borders = 1;
     rounded-corners-exclude = [
       "name = 'xmobar'",
       "class_g = 'dmenu'",
       "!WM_CLASS:s"
     ];

     transition-length = 300
     transition-pow-x = 0.1
     transition-pow-y = 0.1
     transition-pow-w = 0.1
     transition-pow-h = 0.1
     size-transition = true

     blur: {
       method = "kawase";
       strength = 7;
       background = false;
       background-frame = false;
       background-fixed = false;
     }
    '';
  };
  services.udiskie = 
  {
    enable = true;
    tray = "always";
  };

  services.redshift = 
  {
    enable = true;
    provider = "geoclue2";
    tray = true;
  };
  
  programs.git = {
    enable = true;
    userName = "Aleksander Kuś";
    userEmail = "01151536@pw.edu.pl";
  };

  programs.fish = {
    enable = true;
    shellAliases = 
    {
      ".." = "cd .." ;
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";

      # vim and emacs
      em = "/usr/bin/emacs -nw";
      emacs = "emacsclient -c -a 'emacs'";
      doomsync = "~/.emacs.d/bin/doom sync";
      doomdoctor = "~/.emacs.d/bin/doom doctor";
      doomupgrade = "~/.emacs.d/bin/doom upgrade";
      doompurge = "~/.emacs.d/bin/doom purge";

      # Changing "ls" to "exa"
      ls = "exa --color=always --group-directories-first"; # my preferred listing;
      l = "exa -alg --color=always --group-directories-first --git";  # long format;
      ll = "exa -alg --color=always --group-directories-first --git";  # long format;
      lt = "exa -aT --color=always --group-directories-first"; # tree listing

      # get fastest mirrors
      mirror = "sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist";
      mirrors = "sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist";

      # Colorize grep output (good for log files)
      grep = "grep --color=auto";

      # confirm before overwriting something
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";

      # defined functions above
      bk = "backup";
      re = "restore";
      mkcd = "mkdir-cd";
      ex = "extract";

      # recompile and restart xmonad in terminal
      restart = "xmonad --recompile && xmonad --restart";

      # adding flags
      df = "df -h";                          # human-readable sizes;
      du = "du -h";                          # human-readable sizes;
      free = "free -m";                      # show sizes in MB;

      ## get top process eating memory
      psmem = "ps aux | sort -nr -k 4";
      psmem10 = "ps aux | sort -nr -k 4 | head -10";

      ## get top process eating cpu ##
      pscpu = "ps aux | sort -nr -k 3";
      pscpu10 = "ps aux | sort -nr -k 3 | head -10";

      # get error messages from journalctl
      jctl = "journalctl -p 3 -xb";

      # gpg encryption
      # verify signature for isos
      gpg-check = "gpg2 --keyserver-options auto-key-retrieve --verify";
      # receive the key of a developer
      gpg-retrieve = "gpg2 --keyserver-options auto-key-retrieve --receive-keys";

      # switch between shells
      tobash = "sudo chsh $USER -s /bin/bash && echo 'Now log out.'";

      # the terminal rickroll
      rr = "curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash";

      # Drive mounting
      ma = "sudo mount -a";

      # git
      ga = "git add";
      gaa = "git add .";
      gau = "git add -u";
      gai = "git add -i";
      gap = "git add -p";
      gb = "git branch -vv";
      gbd = "git branch -d";
      gbD = "git branch -D";
      gc = "git commit -v";
      gca = "git commit -v --amend";
      gcn = "git commit -v --amend --no-edit";
      gch = "git checkout";
      gcb = "git checkout -b";
      gcl = "git clone";
      gcf = "git config --list";
      gchm = "git checkout (__git.default_branch)";
      gd = "git diff";
      gdc = "git diff --cached";
      gf = "git fetch";
      gfnt = "git fetch --no-tags";
      gfpp = "git fetch --prune --prune-tags";
      gi = "git update-index --assume-unchanged";
      gni = "git update-index --no-assume-unchanged";
      gid = "git ignored";  # requires alias in git config
      gia = "gitk --all";
      gl = "git log --oneline --graph --all -n20";
      glo = "git log --oneline";
      glog = "git log --oneline --graph";
      gloga = "git log --oneline --graph --all";
      gln = "git log --oneline --graph --all -n";
      gp = "git push";
      gri = "git rebase --interactive --rebase-merges";
      gs = "git status";
      gt = "git tag";
      gta = "git tag -a";

      # xclip
      xclip = "xclip -selection clipboard";

      # doublecommander
      dc = "doublecmd \$PWD &> /dev/null";

      # quick folder access aliases
      startsql = "sudo systemctl start mssql-server";
      stopsql = "sudo systemctl stop mssql-server";

      # kill brave before shutting down
      reboot = "killall brave; command reboot";
      poweroff = "killall brave; command poweroff";

      # radio
      melo = "mpv 'https://n-16-8.dcs.redcdn.pl/sc/o2/Eurozet/live/meloradio.livx?audio=5?t=1646159496108' --volume=30";
      zlote = "mpv 'https://radiostream.pl/tuba8936-1.mp3?cache=1646171079' --volume=30";

      # reload fish config
      reload = "source ~/.config/fish/config.fish";
    };
  };

  programs.exa.enable = true;
  home.packages = with pkgs; [
    brave
    btop
    krusader
    onlyoffice-bin
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
    comma
    killall
    #sardi-icons
    fzf
    zsh
    zoxide
    fd
    ripgrep
    zsh-powerlevel10k
    zsh-fast-syntax-highlighting
  ];

  home.sessionVariables = {
    FZF_DEFAULT_COMMAND = "${pkgs.fd}/bin/fd --hidden --no-follow --exclude .git 2>/dev/null";
    #FZF_DEFAULT_COMMAND = "${pkgs.ripgrep}/bin/rg ~ --files --hidden";
  };
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
