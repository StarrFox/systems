{pkgs, ...}: {
  home.packages = with pkgs; [
    aria
    onefetch
    p7zip
    #nnn
    hexyl
    lsof
    erdtree
    yazi
    eza
  ];

  # programs.exa = {
  #   enable = true;
  #   extraOptions = [
  #     "--no-time"
  #     "--color=always"
  #     "--group-directories-first"
  #   ];
  # };

  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza -FlaM --no-time --icons=always --group-directories-first --git";
      tree = "ls --tree --git-ignore";
      lt = "tree";
      gi = "onefetch";
      download = "aria2c --split=10";
      extract = "7z x";
      usage = "erd --human --hidden";
      files = "yazi";
      hex = "hexyl";
      ports = "sudo lsof -nP -iTCP -sTCP:LISTEN";
    };
    # wish they'd just remove this garbage
    interactiveShellInit = "set -U fish_greeting";
    functions = {
      md = {
        body = ''
          command mkdir $argv
          if test $status = 0
              switch $argv[(count $argv)]
                  case '-*'

                  case '*'
                      cd $argv[(count $argv)]
                      return
              end
          end
        '';
      };
      template = {
        body = ''
          nix flake init --template github:StarrFox/templates#$argv[1]
        '';
      };
    };
  };
}
