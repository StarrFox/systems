{pkgs, lib, config, ...}: {
  programs.fish = {
    enable = true;
    # nixpkgs doesn't have meta.mainProgram set for some of these
    # and I was tired of getting warnings about it
    # so we just do /bin/<name> for them
    shellAliases = {
      ls = "${lib.getExe pkgs.eza} -F -laM --no-time --icons=always --group-directories-first --git";
      tree = "ls --tree --git-ignore";
      lt = "tree";
      gi = "${lib.getExe pkgs.onefetch}";
      download = "${lib.getExe pkgs.aria2} --split=10";
      extract = "${lib.getExe pkgs.p7zip} x";
      list = "${lib.getExe pkgs.p7zip} l";
      usage = "${lib.getExe pkgs.erdtree} --human --hidden";
      files = "${pkgs.yazi}/bin/yazi";
      hex = "${lib.getExe pkgs.hexyl}";
      ports = "sudo ${pkgs.lsof}/bin/lsof -nP -iTCP -sTCP:LISTEN";
      branches = "${lib.getExe config.programs.git.package} branch -a";
      clip = "${lib.getExe pkgs.xsel} -ib";
      c = "clear";
      fetch = "${lib.getExe pkgs.fastfetch}";
      code = "codium";
    };
    # wish they'd just remove this garbage
    interactiveShellInit = "set -U fish_greeting";
    functions = {
      md.body = ''
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
      template.body = ''
        ${pkgs.cookiecutter}/bin/cookiecutter gh:StarrFox/templates --directory $argv[1]
      '';
      # we don't use string interpolation here on purpose
      # since not having kitty or wezterm installed in an acceptable state
      img.body = ''
        if test ! -z "$KITTY_INSTALLATION_DIR"
          kitty +icat $argv
        else if test ! -z "$WEZTERM_EXECUTABLE"
          wezterm imgcat $argv
        else
          echo "wezterm nor kitty detected"
        end
      '';
    };
  };
}
