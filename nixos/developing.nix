{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    helix

    nixfmt-classic
    clang-tools
  ];
}
