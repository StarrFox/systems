{ inputs, lib, config, pkgs, ... }: 
let 
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    config = config.nixpkgs.config;
  };
in
{
  # imports = [
  #   (import "${home-manager}/nixos")
  # ];

  # TODO: pass (programs.password-store)

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
      nixpkgs-unstable.imhex
      # erdtree isnt in stable yet
      nixpkgs-unstable.erdtree
    ] ++ [
      python3Packages.ipython
      python3Packages.howdoi
    ];
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -la";
      download = "aria2c --split=10";
      extract = "7z x";
      usage = "erd --human";
      files = "nnn -de";
    };
    # wish they'd just remove this garbage
    interactiveShellInit = "set -U fish_greeting";
  };

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "files.autoSave" = "afterDelay";
      "explorer.confirmDelete" = false;
      "git.confirmSync" = false;
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
        bookmarks = [
          {
            toolbar = true;
            bookmarks = [
              {
                name = "Nix package search";
                url = "https://search.nixos.org/packages?";
              }
              {
                name = "Home manager package search";
                url = "https://mipmip.github.io/home-manager-option-search/";
              }
              {
                name = "Noogle";
                url = "https://noogle.dev/";
              }
              {
                name = "Nix command man";
                url = "https://nixos.org/manual/nix/stable/command-ref/experimental-commands.html";
              }
              {
                name = "anilist";
                url = "https://anilist.co/home";
              }
              {
                name = "anichart";
                url = "https://anichart.net/airing";
              }
              {
                name = "protondb";
                url = "https://www.protondb.com/";
              }
              {
                name = "steamdb";
                url = "https://steamdb.info/";
              }
              {
                name = "librespeed";
                url = "https://librespeed.org/";
              }
            ];
          }
        ];
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

  programs.helix = {
    enable = true;
    # the unstable version has a setting I want
    package = nixpkgs-unstable.helix;
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker.hidden = false;
      };
    };
  };

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
  };
  programs.home-manager.enable = true;
}
