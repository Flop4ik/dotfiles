{ pkgs, lib, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      source-code-pro
      ubuntu_font_family
      dejavu_fonts
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
    ];
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Fira Code" "Source Code Pro" ];
      };
    };
  };
}
