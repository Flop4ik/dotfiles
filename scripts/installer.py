import os
from config import *

class Installer:
    def install_nix_os(self):
        print(intro)
        print("\n" + important)
        
        user_name = input("\nPlease enter your username: ")
        self.change_username(user_name)
        
        self.move_files()
        
        install_flapak = input("\nDo you want to install Zen Browser and Discord Canary from Flatpak? (Y/n): ")
        if install_flapak.lower() == "y":
            self.install_flatpak()
        else:
            print("\nSkipping Flatpak installation.\n")
        
        self.end_config()

    def change_username(self, user_name):

        with open(file_to_change_username, "r") as file:
            lines = file.readlines()

        with open(file_to_change_username, "w") as file:
            for line in lines:
                if "users.users.your-username = {" in line:
                    line = line.replace("your-username", user_name)
                file.write(line)
        
        os.rename(
            os.path.join(nixos_config_dir, "modules", "your-username.nix"),
            os.path.join(nixos_config_dir, "modules", f"{user_name}.nix")
        )
                
        print(f"\n✅ Changed username in {file_to_change_username} to {user_name}\n")

    def move_files(self):
        print("\n--- Moving Configuration Files ---\n")
        
        for file in os.listdir(config_dir):
            os.system(f"mv {file} ~/.config/")
            print(f"  ✓ Moved: {file} to ~/.config/")
            
        os.system(f"mv {nixos_config_dir} ~/")
        print(f"  ✓ Moved: {nixos_config_dir} to ~/\n")

    def install_flatpak(self):
        print("\n--- Installing Flatpak Applications ---\n")
        
        commands = [
            "flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo",
            "flatpak install flathub-beta com.discordapp.DiscordCanary",
            "flatpak install app.zen_browser.zen"
        ]
        
        for command in commands:
            os.system(f"{command}")
            print(f"  ✓ Executed: {command}\n")

    def end_config(self):
        print("\n--- Finalizing Installation ---\n")
        
        rebuild = input("Do you want to rebuild the NixOS configuration? (Y/n): ")
        if rebuild.lower() == "y":
            print("\nRebuilding NixOS configuration...")
            os.system("sudo nixos-rebuild switch --flake ~/nixos-config/")
            print("✅ NixOS configuration rebuilt successfully.\n")
        else:
            print("\nSkipping NixOS configuration rebuild. You may need to do this manually later.\n")
            
        print("\n" + "="*50)
        print("\n✨ Installation complete! Please reboot your system. ✨\n")
        print("If you encounter any issues, please check the documentation")
        print("or contact support.")
        print("\nThank you for using the NixOS dotfiles installer!\n")
        print("="*50 + "\n")

if __name__ == "__main__":
    installer = Installer()
    installer.install_nix_os()