{ pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;         
    syntaxHighlighting.enable = true;     
    enableCompletion = true;              

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"           
        "sudo"     
        "docker"   
        "z"           
        "history"      
        "web-search"
      ];
      theme = "arrow";  
    };
  };

   environment.shells = with pkgs; [ bash zsh ];
   users.defaultUserShell = pkgs.zsh;

}
