{mainUser, ...}: {
  # My git info 
    programs.git = {
      enable = true;
      userName = mainUser;
      userEmail = "suslov9876@gmail.com";
    };
}
