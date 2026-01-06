{ pkgs, stable, ... }:

{
	users.users.flop4ik = {
	  isNormalUser = true;
	  description = "flop4ik";
	  extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; 
	  packages = with pkgs; [
	    vscode
	    obs-studio
	    github-desktop
	    flameshot
		ayugram-desktop	 
		filezilla   
		steam
		stable.hiddify-app
		# stable.telegram-desktop
		stable.ulauncher
		r2modman
		guake
		protonup-rs
		portaudio
		# AmneziaVPN-service
	  ];
	};

	
}
