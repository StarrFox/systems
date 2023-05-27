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
}
