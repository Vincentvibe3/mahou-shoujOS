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
sudo pacman -S imagemagick --noconfirm
sudo pacman -S picom --noconfirm
sudo pacman -S sox --noconfirm
sudo pacman -S noto-fonts --noconfirm
sudo pacman -S noto-fonts-cjk --noconfirm
sudo pacman -S noto-fonts-emoji --noconfirm
sudo pacman -S noto-fonts-extra --noconfirm

#Temp fix for vmware
sudo pacman -U https://archive.archlinux.org/packages/w/webkit2gtk/webkit2gtk-2.36.7-1-x86_64.pkg.tar.zst --noconfirm

#Other
cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo chsh $(whoami) -s /bin/zsh 

#Setup
cd $DOTFILES_DIR
#.config
mkdir ~/.config
cp -r ./config/* ~/.config

#lightdm 
sudo systemctl enable lightdm.service
sudo mkdir -p /usr/share/backgrounds/lightdm
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
sudo cp ./lightdm/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf
sudo cp ./lightdm/madoka.png /usr/share/backgrounds/lightdm


#neofetch
sudo sed -i "s/image_source=\"\/home\/user_to_replace\/kyubey.jpg\"/image_source=\"\/home\/$(whoami)\/kyubey.jpg\"/g" ~/.config/neofetch/config.conf
if ! cat ~/.zshrc | grep "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\""; then
	echo "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\"" >> ~/.zshrc
fi

#Cursors
mkdir -p ~/.icons/madokacursors
cp -r ./cursors/cursors ~/.icons/madokacursors
cp ./cursors/index.theme ~/.icons/madokacursors

#Audio files + images
cp ./mataashita.wav ~
cp ./kyubey.jpg ~

#Grub
cd ./grub
./editName.sh
./apply.sh
