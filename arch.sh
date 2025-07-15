
### DO NOT RUN ###

### DO
	# https://wiki.archlinux.org/title/Improving_performance
	# https://wiki.archlinux.org/title/Kernel_parameters#Parameter_list
	# Secure Boot
	# Delete Gnome Extras - https://archlinux.org/groups/x86_64/gnome/
	# No stow and no config directory


### WSL

## Install
#pwsh> wsl --list --online
#pwsh> wsl --install archlinux
#pwsh> wsl --list --verbose
#pwsh> wsl --update
#pwsh> wsl
passwd
	# enter password
ping archlinux.org
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
timedatectl set-timezone America/Los_Angeles
timedatectl set-ntp true
timedatectl status
pacman -S vim stow sudo mesa vulkan-dzn vulkan-icd-loader usbutils sudo rsync reflector git htop man-pages man-db tree texlive openssh sane imagemagick perl-image-exiftool usbutils # helix ruff bash-language-server texlab evince
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
vim /etc/locale.gen
    # uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
useradd -m masonp
passwd masonp
	# enter password
pacman -Syu
vim /etc/wsl.conf
    # [user]
    # default="user"
EDITOR=vim visudo
exit
#pwsh> wsl --shutdown

## USBIPD
usdbipd.exe list
#ADMIN-pwsh>  usbipd bind --busid [busid]
usbipd.exe attach --wsl --busid [busid]
lsusb
usbipd.exe detach --busid [busid]

## SSH
ssh-keygen -t ed25519 -C "220426478+mason-perdue@users.noreply.github.com"

## GIT
git init
git status
git log

## GitHub
ssh -T git@github.com
git remote add origin git@github.com:mason-perdue/repo.git
git pull origin main

## Config Files
rm ~/.bashrc
cd ~/linux-config/config
stow -t ~/ --restow --dotfiles *
source ~/.bashrc

## NMAP
nmap -v -A -Pn -p 1-65535 192.168.0.112

## PACMAN
pacman -S [package]	# Install
pacman -Runs [package]	# Uninstall
pacman -Syu	# Update
pacman -{Q,S}{s,i} [package]	# (Not) Installed Search/Info
pacman -Qet	# List Installed
pacman -Scc	# Clean


### Bare Metal

## Install
curl -LO https://mirrors.ocf.berkeley.edu/archlinux/iso/latest/archlinux-x86_64.iso
sudo dd bs=4M if=archlinux-x86_46.iso of=/dev/sd[x] conv=fsync oflag=direct status=progress
ip a
rfkill list
timedatectl
# for wifi
	iwctl
	device list
	station [device] scan
	station [device] get-networks
	station [device] connect [wifi name]
	# enter passphrase
	exit
ping archlinux.org
fdisk -l
setfont ter-132b	# setfont to undo
fdisk /dev/sda
d
g
n
+1000M
t
1
n
+8000M
t
19
n
w
fdisk -l /dev/sda
mkfs.fat -F 32 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot
lsblk
pacstrap -K /mnt base linux linux-firmware vim intel-ucode reflector sudo networkmanager rsync xf86-video-intel git gnome grub efibootmgr # helix
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
vim /etc/locale.gen
	# uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KitCom > /etc/hostname	# or "masonDT"
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
pacman -Syu
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
passwd
	# enter password
useradd -m masonp	# or family
passwd masonp	# or family
	# enter password
EDITOR=vim visudo /etc/sudoers
	# add "masonp ALL=(ALL:ALL) ALL" or "family ALL=(ALL:ALL) ALL"
systemctl enable NetworkManager.service
systemctl enable gdm.service
exit
shutdown now

## Setup
ping archlinux.org
# for Wifi
	# nmcli device wifi list
	# nmcli device wifi connect "name" password "pw"
	# nmcli connection show
	# nmcli device
	# ping archlinux.org
# sudo timedatectl set-timezone America/Los_Angeles
# sudo timedatectl set-ntp true
# sudo timedatectl status
sudo pacman -Syu
sudo pacman -S htop gvfs sshfs base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils stow tree spotify-launcher # openssh ufw
rm ~/.bashrc
cd ~/linux-config/config
stow -t ~/ --restow --dotfiles *
source ~/.bashrc
# mkdir ~/linux-config/src
# cd ~/linux-config/src
# git clone https://aur.archlinux.org/google-chrome.git
# cd google-chrome
# makepkg -si
# sudo vim /etc/ssh/sshd.config
	# Port 7530
	# PermitRootLogin no
# sudo ufw default deny incoming
# sudo ufw default allow outgoing
# # sudo ufw allow from 192.168.0.0/24 to any port 7530 proto tcp
# sudo ufw enable
# sudo systemctl enable --now ufw.service
# sudo systemctl status ufw.service
# sudo ufw status verbose
# sudo systemctl enable --now cups.service
# sudo systemctl enable --now sshd.service
# sudo systemctl enable --now bluetooth.service
sudo reboot now
