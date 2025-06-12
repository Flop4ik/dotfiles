# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, spicetify-nix,  ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../modules/fonts.nix
      ../modules/packages.nix
      ../modules/network.nix
      ../modules/shell.nix
      ../modules/spicetify.nix
      # ../modules/zapret_service.nix
      # ../modules/waybar.nix
    ];

    # disabledModules = [ "services/networking/zapret.nix" ];

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

  programs.amnezia-vpn.enable = true;
  # networking.nftables.enable = true;

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = ["https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
      };
      server_names = ["cloudflare" "quad9-dnscrypt-ip4-filter-pri"];
    };
  };
  networking.nameservers = ["127.0.0.1"];

  boot.kernelModules = [ "nfnetlink" "nfnetlink_queue" ];
  services.zapret = {
      enable = true;
      
  params = [
    "--dpi-desync=multidisorder"
    "--dpi-desync-split-pos=midsld"  
    "--dpi-desync-repeats=3"
  ];
  whitelist = [
    "cloudflare-ech.com"
    "dis.gd"
    "discord-attachments-uploads-prd.storage.googleapis.com"
    "discord.app"
    "discord.co"
    "discord.com"
    "discord.design"
    "discord.dev"
    "discord.gift"
    "discord.gifts"
    "discord.gg"
    "discord.media"
    "discord.new"
    "discord.store"
    "discord.status"
    "discord-activities.com"
    "discordactivities.com"
    "discordapp.com"
    "discordapp.net"
    "discordcdn.com"
    "discordmerch.com"
    "discordpartygames.com"
    "discordsays.com"
    "discordsez.com"
    "stable.dl2.discordapp.net"
    "ggpht.com"
    "googlevideo.com"
    "jnn-pa.googleapis.com"
    "wide-youtube.l.google.com"
    "youtube-nocookie.com"
    "youtube-ui.l.google.com"
    "youtube.com"
    "youtubeembeddedplayer.googleapis.com"
    "youtubekids.com"
    "youtubei.googleapis.com"
    "youtu.be"
    "yt-video-upload.l.google.com"
    "ytimg.com"
    "ytimg.l.google.com"
    "frankerfacez.com"
    "ffzap.com"
    "betterttv.net"
    "7tv.app"
    "7tv.io"
    ];

  
    };


#   services.zapret = {
#     enable = true;
#     mode = "nfqws";
# 
#     settings = ''
# SET_MAXELEM=522288
# IPSET_OPT="hashsize 262144 maxelem $SET_MAXELEM"
# 
# IP2NET_OPT4="--prefix-length=22-30 --v4-threshold=3/4"
# IP2NET_OPT6="--prefix-length=56-64 --v6-threshold=5"
# AUTOHOSTLIST_RETRANS_THRESHOLD=3
# AUTOHOSTLIST_FAIL_THRESHOLD=3
# AUTOHOSTLIST_FAIL_TIME=60
# AUTOHOSTLIST_DEBUGLOG=0
# 
# MDIG_THREADS=30
# 
# GZIP_LISTS=1
# QUIC_PORTS=50000-65535
# 
# MODE_HTTP=1
# MODE_HTTP_KEEPALIVE=0
# MODE_HTTPS=1
# MODE_QUIC=1
# MODE_FILTER=none
# 
# DESYNC_MARK=0x40000000
# DESYNC_MARK_POSTNAT=0x20000000
# NFQWS_OPT_DESYNC="--dpi-desync=fake --dpi-desync-ttl=0 --dpi-desync-ttl6=0 --dpi-desync-fooling=badsum"
# NFQWS_OPT_DESYNC_HTTP="--dpi-desync=split --dpi-desync-ttl=5"
# NFQWS_OPT_DESYNC_HTTPS="--dpi-desync=fake --dpi-desync-ttl=5"
# NFQWS_OPT_DESYNC_QUIC="--dpi-desync=fake,tamper --dpi-desync-repeats=6 --dpi-desync-any-protocol"
# 
# TPWS_OPT="--hostspell=HOST --split-http-req=method --split-pos=3 --hostcase --oob"
# 
# FLOWOFFLOAD=donttouch
# 
# INIT_APPLY_FW=1
# 
# DISABLE_IPV6=1
#     '';
#   };
  # Terminal

  environment.sessionVariables.TERMINAL = "kitty";


  # Default browser

  systemd.user.services.set-default-browser = {
    description = "Set Zen Browser as default";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xdg-utils}/bin/xdg-settings set default-web-browser app.zen_browser.zen.desktop";
    };
  };

  services.openssh = {
    enable = true;    
    permitRootLogin = "yes";       
    passwordAuthentication = true;
    # ports = [ 22 ];                
  };

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
  services.gnome.gnome-keyring.enable = true;

  # services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.gdm = {  
    enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
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
