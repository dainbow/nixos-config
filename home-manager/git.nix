{ ... }: {
  # My git info 
  programs.git = {
    enable = true;
    userName = "dainbow";
    userEmail = "suslov9876@gmail.com";
    extraConfig = { push.autoSetupRemote = true; };

    delta.enable = true;
  };
}
