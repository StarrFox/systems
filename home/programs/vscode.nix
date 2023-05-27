{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    userSettings = {
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
      "python.analysis.typeCheckingMode" = "strict";
      "python.venvPath" = "~/.cache/pypoetry/virtualenvs";
      "python.formatting.provider" = "black";
      "python.testing.pytestEnabled" = true;
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
      kamadorueda.alejandra
      viktorqvarfordt.vscode-pitch-black-theme
    ];
  };
}
