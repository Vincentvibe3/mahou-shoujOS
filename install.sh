DOTFILES_DIR=$(pwd)

#Pacman
#sudo pacman -S xdg-user-dirs --noconfirm
#sudo pacman -S rofi --noconfirm
#sudo pacman -S awesome --noconfirm
#sudo pacman -S alacritty --noconfirm
#sudo pacman -S lightdm --noconfirm
#sudo pacman -S lightdm-webkit2-greeter --noconfirm
#sudo pacman -S firefox --noconfirm
#sudo pacman -S neofetch --noconfirm
#sudo pacman -S neovim --noconfirm
#sudo pacman -S zsh --noconfirm

#Other
cd ~
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Setup
cd $DOTFILES_DIR
#os-release
./os-release-edit.sh
#Grub
cd ./grub
./editName.sh
./apply.sh
