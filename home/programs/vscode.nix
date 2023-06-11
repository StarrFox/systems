{
  pkgs,
  starrpkgs,
  ...
}: {
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
      "files.autoSave" = "afterDelay";
      "explorer.confirmDelete" = false;
      "explorer.confirmDragAndDrop" = false;
      "git.confirmSync" = false;
      "git.autofetch" = true;
      "window.zoomLevel" = 1;
      # NOTE: this requires the pitch black theme listed in extensions
      "workbench.colorTheme" = "Pitch Black";
      "workbench.startupEditor" = "none";
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      # NOTE: options are off, basic, and strict
      "python.analysis.typeCheckingMode" = "basic";
      "python.venvPath" = "~/.cache/pypoetry/virtualenvs";
      "python.formatting.provider" = "black";
      "python.testing.pytestEnabled" = true;
      "python.terminal.activateEnvironment" = false;
      "[python]" = {
        "editor.formatOnType" = true;
      };
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
      };
      "zig.zls.path" = "zls";
      "zig.zls.checkForUpdate" = false;
      "editor.quickSuggestions" = {
        "other" = "inline";
      };
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
      viktorqvarfordt.vscode-pitch-black-theme
      skellock.just
      gruntfuggly.todo-tree
      starrpkgs.vscord
      starrpkgs.vscode-zig
      github.vscode-github-actions
    ];
  };
}
