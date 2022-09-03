DOTFILES_DIR=$(pwd)

#Pacman
sudo pacman -S xdg-user-dirs --noconfirm
sudo pacman -S rofi --noconfirm
sudo pacman -S awesome --noconfirm
sudo pacman -S alacritty --noconfirm
sudo pacman -S lightdm --noconfirm
sudo pacman -S lightdm-webkit2-greeter --noconfirm
sudo pacman -S firefox --noconfirm
sudo pacman -S neofetch --noconfirm
sudo pacman -S neovim --noconfirm
sudo pacman -S zsh --noconfirm
sudo pacman -S jp2a --noconfirm

#Other
cd ~
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
sudo chsh $(whoami) -s /bin/zsh 

#Setup
cd $DOTFILES_DIR
#lightdm 
sudo systemctl enable lightdm.service
sudo sed -i 's/greeter-session=lightdm-*-greeter/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
#neofetch
if ! cat ~/.zshrc | grep "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\""; then
	echo "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\"" >> ~/.zshrc
fi
#os-release
./os-release-edit.sh
#.config
cp -r config/* ~/.config
#Audio files + images
cp ./mataashita.wav ~
cp ./kyubey.jpg ~
#Grub
cd ./grub
./editName.sh
./apply.sh
