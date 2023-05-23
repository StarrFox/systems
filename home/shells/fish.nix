{ inputs, lib, config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "exa -la";
      tree = "ls --tree";
      lt = "tree";
      gi = "onefetch";
      download = "aria2c --split=10";
      extract = "7z x";
      usage = "erd --human";
      files = "nnn -de";
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
    };
  };
}