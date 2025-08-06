{ pkgs, ... }: {
  security.pam.yubico = {
    enable = true;
    debug = false;
    mode = "challenge-response";
    id = [ "29471287" ];
  };

  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [ yubioath-flutter ];
}
