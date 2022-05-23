{ config, pkgs, ... }:
let 
  my-python-packages = python-packages: with python-packages; [ 
    pandas
    requests
    numpy
    numba
    scipy
     #other python packages you want
  ];
  python-with-my-packages = pkgs.python3.withPackages my-python-packages;
in
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
    settings = 
    {
      add_newline = false;
      line_break.disabled = true;
    };
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
  home.file.".config/nitrogen/bg-saved.cfg".source = ./bg-saved.cfg;
  #home.file.".config/fish/config.fish".source = ./config.fish;
  #services.gnome-keyring.enable = true;
  #services.gnome-keyring.components = [ "secrets" ];
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
      size = 8;
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
    fadeSteps = [ "0.09" "0.09" ];
    inactiveOpacity = "0.8";
    activeOpacity = "0.9";
    menuOpacity = "0.8";
    opacityRule = [
      "75:name *?= 'xmobar'"
      "80:class_g *?= 'Steam'"
    ];
    backend = "glx";
    blur = true;
    blurExclude = [
      "class_g = 'Alacritty'"
      "class_g = 'Code'"
      "name *?= 'xmobar'"
    ];
    experimentalBackends = true;
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
  
  programs.git = {
    enable = true;
    userName = "Aleksander Kuś";
    userEmail = "01151536@pw.edu.pl";
  };

  services.blueman-applet.enable = true;
  services.dunst.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = 
    {
      ".." = "cd .." ;
      "..." = "cd ../..";
      ".3" = "cd ../../..";
      ".4" = "cd ../../../..";
      ".5" = "cd ../../../../..";

      # Changing "ls" to "exa"
      ls = "exa --color=always --group-directories-first"; # my preferred listing;
      l = "exa -alg --color=always --group-directories-first --git";  # long format;
      ll = "exa -alg --color=always --group-directories-first --git";  # long format;
      lt = "exa -aT --color=always --group-directories-first"; # tree listing

      # Colorize grep output (good for log files)
      grep = "grep --color=auto";

      # confirm before overwriting something
      cp = "copy";
      mv = "mv -i";
      rm = "remove";

      # defined functions above
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
      reboot = "pkill brave; command reboot";
      poweroff = "pkill brave; command poweroff";

      # radio
      melo = "mpv 'https://n-16-8.dcs.redcdn.pl/sc/o2/Eurozet/live/meloradio.livx?audio=5?t=1646159496108'";
      zlote = "mpv 'https://radiostream.pl/tuba8936-1.mp3?cache=1646171079'";

      # reload fish config
      reload = "source ~/.config/fish/config.fish";
    };
    interactiveShellInit = ''
      set -U fish_user_paths $fish_user_paths $HOME/.local/bin/ $HOME/bin
      set fish_greeting                      # Supresses fish's intro message
      set TERM "xterm-256color"              # Sets the terminal type
      setenv EDITOR vim
      setenv VISUAL vim
      setenv MANPAGER '/bin/sh -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
      setenv QT_QPA_PLATFORMTHEME "qt5ct"

      if [ $fish_key_bindings = fish_vi_key_bindings ]
        bind -Minsert ! __history_previous_command
        bind -Minsert '$' __history_previous_command_arguments
      else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
      end

      ### SSH AGENT ###
      if test (pgrep ssh-agent | wc -l) -gt 1
          killall ssh-agent
      end
      if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
      end
    '';
    functions = {
      fish_user_key_binding.body = "fish_vi_key_bindings";
      __history_previous_command_arguments.body = ''
        switch (commandline -t)
        case "!"
          commandline -t ""
          commandline -f history-token-search-backward
        case "*"
          commandline -i '$'
        end
      '';
      __history_previous_command.body = ''
        switch (commandline -t)
        case "!"
          commandline -t $history[1]; commandline -f repaint
        case "*"
          commandline -i !
        end
      '';
      copy.body = ''
        set count (count $argv | tr -d \n)
        if test "$count" = 2; and test -d "$argv[1]"
          set from (echo $argv[1] | trim-right /)
          set to (echo $argv[2])
              command cp -r $from $to
        else
            command cp $argv
        end
      '';
      remove.body = ''
        set original_args $argv

        argparse r f -- $argv

        if not set -q _flag_r || set -q _flag_f
            command rm $original_args
            return
        end

        function confirm-remove --argument message
            if not confirm $message
                echo 'Cancelling.'
                exit 1
            end
        end

        for f in $argv
            set gitdirs (find $f -name .git)
            for gitdir in $gitdirs
                confirm-remove "Remove .git directory $gitdir?"
                command rm -rf $gitdir
            end
        end

        command rm $original_args
      '';
      bak.body = "command cp $argv[1] $argv[1].bak";
      rest.body = "command mv $argv[1] (echo $argv[1] | sed s/.bak//)";
      mkcd.body = "mkdir -p $argv && cd $argv";
      trim-right.body = ''sed "s|$char\$||"'';

      #Git functions
      "__git.current_branch" = {
        description = "Output git's current branch name";
        body = ''
          begin
            git symbolic-ref HEAD; or \
            git rev-parse --short HEAD; or return
          end 2>/dev/null | sed -e 's|^refs/heads/||'
        '';
      };

      "__git.default_branch" = {
        description = "Use init.defaultBranch if it's set and exists, otherwise use main if it exists. Falls back to master";
        body = ''
          command git rev-parse --git-dir &>/dev/null; or return
          if set -l default_branch (command git config --get init.defaultBranch)
            and command git show-ref -q --verify refs/heads/{$default_branch}
            echo $default_branch
          else if command git show-ref -q --verify refs/heads/main
            echo main
          else
            echo master
          end
        '';
      };
      "__git.branch_has_wip" = {
        description = "Returns 0 if branch has --wip--, otherwise 1";
        body = ''git log -n 1 2>/dev/null | grep -qc "\-\-wip\-\-"'';
      };
      gignored = {
        description = "list temporarily ignored files";
        wraps = ''grep "^[[:lower:]]"'';
        body = ''git ls-files -v | grep "^[[:lower:]]" $argv'';
      };
      gbage = {
        description = "List local branches and display their age";
        body = ''git for-each-ref --sort=committerdate refs/heads/ \
          --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))"
        '';
      };
      gbda = {
        description = "Delete all branches merged in current HEAD";
        body = ''
          git branch --merged | \
          command grep -vE  '^\*|^\s*(master|main|develop)\s*$' | \
          command xargs -n 1 git branch -d
          '';
      };
    };
  };

  # programs.zsh = {
  #   enable = true;
  #   dotDir = ".config/zsh";
  #   history = {
  #     path = "${config.xdg.dataHome}/zsh/history";
  #     extended = true;
  #     ignoreDups = true;
  #     share = true;
  #   };

  #   enableCompletion = true;
  #   enableAutosuggestions = true;
  #   #enableSyntaxHighlighting = true;
  #   autocd = true;

  #   # envExtra = ''
  #   #   #${builtins.readFile ./env.zsh}
  #   # '';
  #   # initExtraFirst = ''
  #   #   #source /home/alex/dotfiles/users/alex/main.zsh
  #   # '';

  #   initExtra = ''

  #       repeat $LINES print
  #       if [[ -r "''${XFG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
  #         source "''${XFG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
  #       fi

  #       source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

  #       [[ ! -f /home/alex/.config/zsh/.p10k.zsh ]] || source /home/alex/.config/zsh/.p10k.zsh
  #   '';

  #   plugins = [
  #     {
  #       name = "fast-syntax-highlighting";
  #       file = "fast-syntax-highlighting.plugin.zsh";
  #       src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
  #     }
  #   ];


  #   sessionVariables = {
  #     ZSH_CACHE = "${config.xdg.cacheHome}/zsh";
  #     ZSH_DATA = "${config.xdg.dataHome}/zsh";
  #   };
  # };


  programs.java = {
    enable = true;
    package = pkgs.jdk8;
  };

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
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
    libsForQt5.ark
    libsForQt5.dolphin
    libsForQt5.kdegraphics-thumbnailers
    xmobar
    comma
    sardi-icons
    fzf
    fd
    ripgrep
    polymc
    dmenu
    fusuma
    brightnessctl
    mlocate
    zip
    unzip
    mpv
    fsearch
    celluloid
    docker
    docker-compose_2
    jetbrains.rider
    jetbrains.pycharm-community
    dotnet-sdk
    python-with-my-packages
    ntfs3g
    libnotify
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
    ${pkgs.fusuma}/bin/fusuma -c "/home/alex/.config/fusuma/config.yml" &
    xsetroot -cursor_name left_ptr
    '';
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
