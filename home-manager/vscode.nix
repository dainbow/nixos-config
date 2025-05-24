{ pkgs, ... }: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

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

        "tinymist.preview.scrollSync" = "onSelectionChange";
        "tinymist.formatterMode" = "typstyle";
      };

      extensions = with pkgs.vscode-marketplace;
        with pkgs.vscode-extensions; [
          mkhl.direnv
          redhat.java
          myriad-dreamin.tinymist
          llvm-vs-code-extensions.vscode-clangd
          # rust-lang.rust-analyzer
          ms-azuretools.vscode-docker
          ms-vscode-remote.remote-containers
          haskell.haskell
          justusadam.language-haskell
          tomoki1207.pdf
          dart-code.flutter
          dart-code.dart-code
          jasew.vscode-helix-emulation
        ];
    };
  };
}
