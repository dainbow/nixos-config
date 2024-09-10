{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    helix

    nil
    nixfmt-classic
    clang-tools
    # typst-lsp
    rust-analyzer
    yaml-language-server
    taplo
    marksman
    cmake-language-server
    bash-language-server
  ];
}
