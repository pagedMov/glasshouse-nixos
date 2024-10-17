{
  pkgs,
  inputs,
  ...
}: {
  home.persistence."/persist/home" = {
    directories = [
      ".sysflake"
      ".password-store"
      ".local/share/keyrings"
      ".local/share/.Trash-1000"
      ".local/share/direnv"
      ".ssh"
      ".gnupg"
      "Coding"
      "Videos"
      "Documents"
      "Pictures"
      "Music"
      "Downloads"
      "Games"
      "Misc"
			"Virtualization"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".zsh_history"
    ];
    allowOther = true;
  };
}
