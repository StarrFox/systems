{
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (osConfig.nixpkgs) config;
  };

  starrpkgs = inputs.starrpkgs.packages.${pkgs.system};
in {
  # TODO: don't do this
  # this is just incase I forget to add them to the enviroment
  home.packages = with pkgs; [
    nil
    black
    rust-analyzer
    zls
  ];

  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
      "editor.fontSize" = 17;
      "editor.fontLigatures" = true;
      "editor.fontFamily" = "'FiraCode Nerd Font Mono', 'Droid Sans Mono', 'monospace'";
      "editor.formatOnSaveMode" = "file";
      "window.zoomLevel" = 1;
      "files.autoSave" = "afterDelay";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      # NOTE: this requires the pitch black theme listed in extensions
      #"workbench.colorTheme" = "Pitch Black";
      # NOTE: requires andromeda extension below
      #"workbench.colorTheme" = "Andromeda Bordered";
      "workbench.colorTheme" = "Monokai High Contrast";
      "workbench.startupEditor" = "none";
      # "editor.quickSuggestions" = {
      #   "other" = "inline";
      # };

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
      };

      "zig.path" = "";
      "zig.zls.path" = "zls";
      "zig.zls.checkForUpdate" = false;

      "isort.args" = ["--profile" "black" "--skip-gitignore"];
      "[python]" = {
        "editor.formatOnSave" = true;
        #"editor.formatOnType" = true;
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = true;
        };
      };
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      # NOTE: options are off, basic, and strict
      "python.analysis.typeCheckingMode" = "basic";
      "python.venvPath" = "~/.cache/pypoetry/virtualenvs";
      "python.testing.pytestEnabled" = true;
      "python.terminal.activateEnvironment" = false;
      "python.analysis.completeFunctionParens" = true;
      #"python.analysis.autoFormatStrings" = true;
      "python.analysis.diagnosticMode" = "workspace";
      "python.analysis.inlayHints.callArgumentNames" = "all";
      "python.analysis.inlayHints.pytestParameters" = true;
      "python.analysis.exclude" = [
        "result"
        ".direnv"
        ".venv"
        "venv"
      ];
      "autoDocstring.docstringFormat" = "google-notypes";

      "lldb.suppressUpdateNotifications" = true;
      #"workbench.sideBar.location" = "right";
      #"editor.multiCursorModifier" = "ctrlCmd";
      "direnv.restart.automatic" = true;
      "cmake.showOptionsMovedNotification" = false;
      "cmake.configureOnOpen" = false;

      "terminal.integrated.commandsToSkipShell" = [
        "workbench.action.terminal.copySelection"
        "workbench.action.terminal.paste"
      ];
    };

    extensions = with pkgs.vscode-extensions; [
      njpwerner.autodocstring
      tamasfe.even-better-toml
      usernamehw.errorlens
      davidanson.vscode-markdownlint
      jnoortheen.nix-ide
      ms-python.python
      ms-python.vscode-pylance
      mkhl.direnv
      editorconfig.editorconfig
      matklad.rust-analyzer
      kamadorueda.alejandra
      skellock.just
      gruntfuggly.todo-tree
      github.vscode-github-actions
      github.vscode-pull-request-github
      mhutchie.git-graph
      vadimcn.vscode-lldb
      serayuzgur.crates
      humao.rest-client
      ms-vscode.cpptools
      twxs.cmake
      ms-vscode.cmake-tools
      ms-vscode.makefile-tools

      starrpkgs.vscord
      starrpkgs.vscode-zig
      starrpkgs.vscode-coconut

      # themes
      viktorqvarfordt.vscode-pitch-black-theme
      starrpkgs.andromeda
      starrpkgs.monokai-highcontrast

      nixpkgs-unstable.vscode-extensions.ms-python.isort
      nixpkgs-unstable.vscode-extensions.ms-python.black-formatter
    ];
  };
}
