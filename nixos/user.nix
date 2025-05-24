{ mainUser, ... }: {
  # Default shell is zsh
  users = {
    mutableUsers = false;

    # Define a user account. 
    users."${mainUser}" = {
      isNormalUser = true;
      home = "/home/${mainUser}";
      hashedPassword =
        "$6$9IC0fdnfmsnoOEbg$.jGDMrzeKvaembPfo.31XSjbQkyvHtVg8zPM494SBJMhF8iPkxpXG1nfXDe9E6fY3/KkoLezFVUnoHmB.7Dj80";
      extraGroups = [ "wheel" "input" "networkmanager" "docker" "adbusers" ];
    };
  };

  programs.adb.enable = true;
}
