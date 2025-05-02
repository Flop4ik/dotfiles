import os

dir_path = os.path.join(os.path.dirname(__file__))
root_dir = os.path.abspath(os.path.join(dir_path, os.pardir))
configuration_dir = os.path.join(root_dir, "configuration")
config_dir = os.path.join(configuration_dir, ".config")
nixos_config_dir = os.path.join(configuration_dir, "nixos-config")
file_to_change_username = os.path.join(nixos_config_dir, "modules", "your-username.nix")

intro = "\n###########################################\n#                                         #\n#       NIXOS DOTFILES INSTALLER          #\n#                                         #\n#   Welcome to the NixOS dotfiles setup!  #\n#   Maintained by: flop4ik                #\n#                                         #\n###########################################\n"

important = "\n###############################\n#                             #\n#         IMPORTANT           #\n#                             #\n#   If you type an incorrect  #\n#   username, the config      #\n#   won't work properly.      #\n#                             #\n###############################\n"
