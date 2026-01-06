{ pkgs, config, ... }:

{



  imports =
    [ 
      ./flop4ik.nix
    ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal
    kitty
    vim
    neovim
    micro
    fastfetch
    zsh

    # Wayland utilities
    waybar
    fuzzel
    swww
    swaylock
    wl-clipboard
    clipman
    pamixer
    wlogout
    hyprpicker
    swaynotificationcenter
	dunst
	rofi
	eww

    # System tools
    wget
    git
    appimage-run
    python3
    go
    pavucontrol
    unzip
    btop
    vlc
    # jdk17
    jdk21
    # jdk8
    # jdk11

    # Network (zapret is Russian-specific filtering tool)
    zapret
    iptables
    nftables
    gawk
    blueman
    gale
    ffmpeg
    gradle
    xorg.libXxf86vm
    libpulseaudio
    libGL
    alsa-lib


    # Gnome
    gnome-tweaks
    catppuccin-sddm
    # catppuccin-gtk
    gnome-themes-extra

    #Dependencies
    gcc
    uv
    file
    xclip
    gcc
    libgcc
    gnumake
    cmake
    extra-cmake-modules
    libv4l
    v4l-utils
    
    # proton-ge

    amnezia-vpn
    amneziawg-tools 


    ntfs3g

    bun

    

    #Screenshots
    grim
    slurp
  ];


  # Flatpak
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

}
