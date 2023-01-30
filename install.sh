#/bin/bash
echo "Bienvenido al Script de  Instalacion de BSPWM para ArchLinux"
echo "Hecho por Dayron Romero"
echo ":3"
# Espera 5s en la terminal
sleep 5
# Limpia la terminal de la consola
clear

# Comandos Iniciales
echo "Procedemos a actualizar la distribucion Rolling Release e instalacion de la base BSPWM"
sudo pacman -Sy --noconfirm && sudo pacman -S base-devel nitrogen bspwm sxhkd xorg-xinit rofi polybar zsh git feh tcc glibc make pam xcb-util libxcb xorg xorg-auth util-linux ncurses tilix ttf-fire-code networkmanager iwd pcmanfm samba wget python python-pip firewalld pulseaudio pulseaudio-alsa pavucontrol--noconfirm
# Procedemos a clonar yay
echo "Se procede a clonar y compilar yay"
git clone https://aur.archlinux.org/yay-git
cd yay
makepkg -si
cd ..
# Se elimina el repositorio yay por motivo estetico
rm -R -f yay/
# Espera 5s en la terminal
sleep 5
# Limpia la terminal de la consola
clear

# Se Procede a la creacion de la carpeta .config
mkdir .config
cd .config
mkdir sxhkd bspwm
cd ..
# Espera 5s en la terminal
sleep 5
# Limpia la terminal de la consola
clear

# Se Procede a copiar y a configurar bspwm
	# Se copia el archivo bspwmrc
echo "Se realiza la copia del archivo bspwmrc"
echo "Copiando ..." 
cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
echo "Copia Completa !"

echo ""
# Espera 5s en la terminal
sleep 5
# Limpia la terminal de la consola
clear

	# Se copia el archivo .sxhkdrc
echo "Se realiza la copia del archivo sxhkdrc
echo "Copiando ..."
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
echo "Copia Completa !"

echo ""
# Espera 5s en la terminal
sleep 5
# Limpia la terminal de la consola
clear

# Instalando yay
echo "Instalamos ly"
cd
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
make
make run
make install installsystemd
sudo systemctl enable ly.service
cd
rm -R -f ly/
clear
sleep 5

# creacion del archivo .xinitrc
echo "Creacion del archivo .xinitrc y configurandolo"
cd
echo
touch .xinitrc
echo "sxhkd &\exec bspwm"| sudo .xinitrc
clear
sleep 5 

# Instalamos zsh
echo "Instalando zsh ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cd

# instalamos los programas necesarios para el area de optimizacion
clear
sleep 5
echo "Instalando los programas necesarios"
yay -S visual-studio-code-bin google-chrome firefox

echo ""
echo "Se activa el servicio samba"

# Se activa SAMBA-Service
echo "Se activa el servicio iwd"
sudo systemctl enable smb.service --now
firewall-cmd --permanent --add-service={samba,samba-client,samba-dc} --zone=home
clear
sleep 5 

# Se activa IWD
echo "Se activa el servicio iwd"
sudo systemctl enable iwd --now

# Descarga el wallpaper
echo "Empezando descarga de Wallpaper"
cd
mkdir Downloads Documents Desktop Images
cd Documents/
mkdir Github Documentacion
cd Documentacion
mkdir Personalizacion
cd Personalizacion
mkdir Files
cd Files
mkdir Wallpaper
cd Wallpaper
wget https://i.ibb.co/jysssPf/911484.jpg
clear

# Instalacion y configuracion de temas de polybar
echo "Instalacion y configuracion polybar-themes"
cd
git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
cd polybar-themes/
chmod +x setup.sh
bash setup.sh
cd
echo "Escritura y configuracion de archivos en bspwmrc y sxhkdrc"
echo "bash ~/.config/polybar/launch.sh --material"| sudo ~/.config/bspwm/bspwmrc
echo "feh --bg-scale ~/Documents/Documentacion/Personalizacion/Files/Wallpaper/911484.jpg"| sudo ~/.config/bspwm/bspwmrc"
cd
clear 

# Instalacion y activacion de pulseaudio
echo "Instalando y activando pulseaudio ...."
sudo systemctl enable pulseaudio --now

# End of the File
sudo reboot now