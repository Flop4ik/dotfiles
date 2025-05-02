{ config, ... }:

{
	networking.hostName = "nixos";
	
	
	networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
	networking.networkmanager = {
	  enable = true;
	  dns = "none";  
	  insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
	};

	networking.firewall = {
	  enable = false;
	  allowedTCPPorts = [ 443 80 53 ];
	  allowedUDPPorts = [ 53 443 1194 ]; 
	  checkReversePath = "loose";
	};

}
