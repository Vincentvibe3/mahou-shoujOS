DOTFILES_DIR=$(pwd)

#Pacman
sudo pacman -S xdg-user-dirs --noconfirm --needed
sudo pacman -S rofi --noconfirm --needed
sudo pacman -S awesome --noconfirm --needed
sudo pacman -S alacritty --noconfirm --needed
sudo pacman -S lightdm --noconfirm --needed
# sudo pacman -S lightdm-webkit2-greeter --noconfirm --needed
sudo pacman -S firefox --noconfirm --needed
sudo pacman -S neofetch --noconfirm --needed
sudo pacman -S neovim --noconfirm --needed
sudo pacman -S zsh --noconfirm --needed
sudo pacman -S jp2a --noconfirm --needed
sudo pacman -S imagemagick --noconfirm --needed
sudo pacman -S picom --noconfirm --needed
sudo pacman -S sox --noconfirm --needed
sudo pacman -S noto-fonts --noconfirm --needed
sudo pacman -S noto-fonts-cjk --noconfirm --needed
sudo pacman -S noto-fonts-emoji --noconfirm --needed
sudo pacman -S noto-fonts-extra --noconfirm --needed
sudo pacman -S dolphin --noconfirm --needed


cd ~

# web greeter
mkdir aur
cd aur
git clone https://aur.archlinux.org/web-greeter.git web-greeter
cd web-greeter
yes | makepkg -s -i

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
sudo sed -i 's/#greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
sudo sed -i 's/greeter-session=.*/greeter-session=web-greeter/g' /etc/lightdm/lightdm.conf
sudo cp ./lightdm/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf
sudo cp ./lightdm/madoka.png /usr/share/backgrounds/lightdm/madoka.png


#neofetch
sudo sed -i "s/image_source=\"\/home\/user_to_replace\/kyubey.jpg\"/image_source=\"\/home\/$(whoami)\/kyubey.jpg\"/g" ~/.config/neofetch/config.conf
if ! cat ~/.zshrc | grep "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\""; then
	echo "alias neofetch=\"neofetch --config ~/.config/neofetch/config.conf\"" >> ~/.zshrc
fi

#Cursors
mkdir -p ~/.config/gtk-3.0
cp ./cursors/default/settings.ini  ~/.config/gtk-3.0/settings.in
mkdir -p ~/.icons/default
cp ./cursors/default/index.theme ~/.icons/default/index.theme
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
