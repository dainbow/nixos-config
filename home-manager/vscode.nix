{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    package = pkgs.vscodium;

    userSettings = { "direnv.restart.automatic" = true; };

    extensions = with pkgs.vscode-extensions; [
      mkhl.direnv
      redhat.java
      myriad-dreamin.tinymist
      llvm-vs-code-extensions.vscode-clangd
      rust-lang.rust-analyzer
    ];
  };
}
