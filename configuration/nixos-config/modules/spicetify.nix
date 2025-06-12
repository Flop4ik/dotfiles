{spicetify-nix, pkgs,  ... }:

{
	programs.spicetify = {
	  enable = true;
	  theme = spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
	  

	  colorScheme = "mocha";  


    enabledExtensions = with spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      fullAppDisplay
      shuffle
      adblock
      history
      beautifulLyrics
      playlistIcons
    ];


	};
}
