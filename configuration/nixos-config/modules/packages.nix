{ pkgs, config, ... }:

{



  imports =
    [ 
      ./your-user-name.nix
    ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Terminal
    kitty
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
    dunst
    pamixer
    wlogout
    hyprpicker

    # System tools
    wget
    git
    appimage-run
    python3
    pavucontrol

    # Network (zapret is Russian-specific filtering tool)
    zapret

    # Gnome
    gnome-tweaks
    catppuccin-sddm
    catppuccin-gtk
    gnome-themes-extra
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
