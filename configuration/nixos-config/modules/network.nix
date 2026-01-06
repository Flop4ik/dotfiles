{ config, ... }:

{
	networking.hostName = "nixos";
	
	
# 	networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
# 	networking.networkmanager = {
# 	  enable = true;
# 	  dns = "systemd-resolved"; 
# 	  insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
# 	};
# 
# 	networking.firewall = {
# 	  enable = true;
# 	  allowedTCPPorts = [ 443 80 53 22 ];
# 	  allowedUDPPorts = [ 53 443 1194 ]; 
# 	  checkReversePath = "loose";
# 	};

	programs.mtr.enable = true;
	networking.firewall.checkReversePath = "loose";

	networking.nat.enable = true;
	networking.nat.externalInterface = "enp3s0:";  # e.g., "eth0" or "wlan0" – check with `ip link`
	networking.nat.internalInterfaces = [ "tun0" ];

	networking = {
		nameservers = [ "1.1.1.1" "8.8.8.8" ];
		enableIPv6 = false;
		firewall.enable = true;
	};

	services.resolved = {
	  enable = true;
	  fallbackDns = ["1.1.1.1" "1.0.0.1"];
	};
	

}
