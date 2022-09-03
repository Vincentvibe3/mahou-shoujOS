sudo cp -r ./dracula /usr/share/grub/themes
sudo sed -i 's/GRUB_THEME="/path/to/gfxtheme"/GRUB_THEME="/boot/grub/themes/dracula/theme.txt"/g' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
