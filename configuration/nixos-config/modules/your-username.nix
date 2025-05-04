{ pkgs, unstable, ... }:

{
	users.users.flop4ik = {
	  isNormalUser = true;
	  description = "User packages configuration";
	  extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; 
	  packages = with pkgs; [
	    home-manager
	    vscode
	    spotify
	    obs-studio
	    prismlauncher
	    telegram-desktop
	    hiddify-app
	    vesktop
	    equicord
	    github-desktop
	    flameshot
	    mongodb-compass
	  ];
	};
}
