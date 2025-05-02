# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules/fonts.nix
      ../modules/packages.nix
      ../modules/network.nix
      ../modules/shell.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # NVIDIA Drivers
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;  # For 32-bit apps like Steam
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  
  programs.dconf.enable = true; 

  #thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; 
  services.tumbler.enable = true; 

  hardware.nvidia = {
    modesetting.enable = true;     # Required for Wayland
    powerManagement.enable = true; # Better power management
    open = false;                 # Use proprietary driver
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # services.xserver.displayManager.sddm.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";  # Fixes Firefox on Wayland
  # services.xserver.displayManager.sddm.theme = pkgs.catppuccin-sddm;

  services.xserver.displayManager.gdm = {
  
    enable = true;

  };


  
  # Set your time zone.
  time.timeZone = "Asia/Yekaterinburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "workman,";
    options = "grp:alt_shift_toggle";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  programs.hyprland = {
   enable = true;
  };


  # This value determines the NixOS release
  system.stateVersion = "24.11";
}
