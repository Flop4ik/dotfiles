{ pkgs, unstable, ... }:

{
	users.users.flop4ik = {
	  isNormalUser = true;
	  description = "flop4ik";
	  extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; 
	  packages = with pkgs; [
	    home-manager
	    vscode
	    obs-studio
	    prismlauncher
	    telegram-desktop
	    hiddify-app
	    vesktop
	    equicord
	    github-desktop
	    flameshot
	    mongodb-compass
		ayugram-desktop	 
		filezilla   
		heroic
		steam
		unstable.discord
		r2modman
		# AmneziaVPN-service
	  ];
	};

	
}
