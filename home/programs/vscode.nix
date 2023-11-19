{
  pkgs,
  starrpkgs,
  inputs,
  config,
  ...
}: let
  nixpkgs-unstable = import inputs.nixpkgs-unstable {
    system = "${pkgs.system}";
    inherit (config.nixpkgs) config;
  };
in  {
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
      # this allows the black extension to work
      "python.formatting.provider" = "none";
      "python.testing.pytestEnabled" = true;
      "python.terminal.activateEnvironment" = false;
      "[python]" = {
        "editor.formatOnType" = true;
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.codeActionsOnSave" = {
          "source.organizeImports" = true;
        };
      };
      "isort.args" = ["--profile" "black" "--skip-gitignore"];
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
      # "editor.quickSuggestions" = {
      #   "other" = "inline";
      # };
      "python.analysis.completeFunctionParens" = true;
      "python.analysis.autoFormatStrings" = true;
      "python.analysis.diagnosticMode" = "workspace";
      "python.analysis.inlayHints.callArgumentNames" = "all";
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
      github.vscode-github-actions
      github.vscode-pull-request-github
      mhutchie.git-graph
      vadimcn.vscode-lldb
      serayuzgur.crates
      humao.rest-client

      starrpkgs.vscord
      starrpkgs.vscode-zig
      starrpkgs.andromeda

      nixpkgs-unstable.vscode-extensions.ms-python.isort
      nixpkgs-unstable.vscode-extensions.ms-python.black-formatter
    ];
  };
}
