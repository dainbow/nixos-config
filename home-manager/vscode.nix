{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    package = pkgs.vscode;

    userSettings = {
      "direnv.restart.automatic" = true;
      "cmake.saveBeforeBuild" = false;
      "cmake.showOptionsMovedNotification" = false;
      "files.autoSave" = "onFocusChange";
      "cmake.pinnedCommands" = [
        "workbench.action.tasks.configureTaskRunner"
        "workbench.action.tasks.runTask"
      ];
      "haskell.manageHLS" = "PATH";
      "redhat.telemetry.enabled" = false;
    };

    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      redhat.java
      myriad-dreamin.tinymist
      llvm-vs-code-extensions.vscode-clangd
      rust-lang.rust-analyzer
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-containers
      haskell.haskell
      justusadam.language-haskell
    ];
  };
}
