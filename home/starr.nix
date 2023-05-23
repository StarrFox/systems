{ inputs, lib, config, pkgs, ... }: 
let 
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
  starrpkgs = import inputs.starrpkgs {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    programs/helix.nix
    shells/fish.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # NOTE: if switching from plasma consider adding handlr to handle default apps

  home = {
    username = "starr";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11";
    packages = with pkgs; [
      # cli
      aria
      bat
      cava
      comma
      croc
      duf
      drawio
      feh
      ffmpeg
      htop
      httpie
      neofetch
      nethogs
      ncdu
      nnn
      onefetch # TODO: add `git info` which runs onefetch
      p7zip
      python3
      ripgrep
      rsync
      tldr

      # gui
      alacritty
      bitwarden
      #chromium
      discord
      flameshot
      gimp
      kate
      insomnia # this is the rest api gui thing
      obsidian
      mpv
      the-powder-toy
      virt-manager
    ] ++ [
      inputs.nh.packages.${pkgs.system}.default
      inputs.nix_search.packages.${pkgs.system}.default
    ] ++ [
      # I want the latest version
      starrpkgs.imhex
      # erdtree isnt in stable yet
      nixpkgs-unstable.erdtree
    ] ++ [
      python3Packages.ipython
      python3Packages.howdoi
    ] ++ [
      # needed for gpg
      pkgs.pinentry-curses
    ];
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  # programs.fish = {
  #   enable = true;
  #   shellAliases = {
  #     ls = "exa -la";
  #     tree = "ls --tree";
  #     lt = "tree";
  #     gi = "onefetch";
  #     download = "aria2c --split=10";
  #     extract = "7z x";
  #     usage = "erd --human";
  #     files = "nnn -de";
  #   };
  #   # wish they'd just remove this garbage
  #   interactiveShellInit = "set -U fish_greeting";
  #   functions = {
  #     md = {
  #       body = ''
  #         command mkdir $argv
  #         if test $status = 0
  #             switch $argv[(count $argv)]
  #                 case '-*'

  #                 case '*'
  #                     cd $argv[(count $argv)]
  #                     return
  #             end
  #         end
  #       '';
  #     };
  #   };
  # };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "afterDelay";
      "explorer.confirmDelete" = false;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "window.zoomLevel" = 1;
      "[python]" = {
        "editor.formatOnType" = true;
      };
    };
    extensions = with pkgs.vscode-extensions; [
      njpwerner.autodocstring
      bungcip.better-toml
      usernamehw.errorlens
      davidanson.vscode-markdownlint
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      mkhl.direnv
      editorconfig.editorconfig
      matklad.rust-analyzer
    ];
  };

  programs.firefox = {
    enable = true;
    profiles = {
      ${config.home.username} = {
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        settings = {
          "browser.toolbars.bookmarks.visibility" = "always";
        };
      };
    };
  };

  programs.starship = {
    enable = true;
    # we need the latest version for the `heuristic` setting
    package = nixpkgs-unstable.starship;
    settings = {
      username.show_always = true;
      nix_shell.heuristic = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # programs.helix = {
  #   enable = true;
  #   # the unstable version has a setting I want
  #   package = nixpkgs-unstable.helix;
  #   settings = {
  #     theme = "base16_transparent";
  #     editor = {
  #       line-number = "relative";
  #       bufferline = "multiple";
  #       cursor-shape = {
  #         normal = "block";
  #         insert = "bar";
  #         select = "underline";
  #       };
  #       file-picker.hidden = false;
  #     };
  #   };
  # };

  programs.exa = {
    enable = true;
    extraOptions = [
      "--no-time"
      "--color=always"
      "--group-directories-first"
    ];
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
  };

  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userName = "StarrFox";
    userEmail = "StarrFox6312@gmail.com";
    delta.enable = true;
    extraConfig = {
      push.autoSetupRemote = true;
    };
  };
  programs.home-manager.enable = true;
}
