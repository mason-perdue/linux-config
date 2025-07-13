
### DO NOT RUN ###

# DO
	# https://wiki.archlinux.org/title/Improving_performance
	# https://wiki.archlinux.org/title/Kernel_parameters#Parameter_list
	# Secure Boot
	# Delete Gnome Extras - https://archlinux.org/groups/x86_64/gnome/

curl -LO https://mirrors.ocf.berkeley.edu/archlinux/iso/latest/archlinux-x86_64.iso
sudo dd bs=4M if=archlinux-x86_46.iso of=/dev/sdx conv=fsync oflag=direct status=progress
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
pacstrap -K /mnt base linux linux-firmware intel-ucode helix reflector sudo networkmanager rsync xf86-video-intel git gnome grub efibootmgr
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
hwclock --systohc
helix /etc/locale.gen
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
useradd -m masonp
passwd masonp
EDITOR=helix visudo /etc/sudoers
	# add "masonp ALL=(ALL:ALL) ALL" or "family ALL=(ALL:ALL) ALL"
systemctl enable NetworkManager.service
systemctl enable gdm.service
exit
shutdown now

ping archlinux.org
# for Wifi
	nmcli device wifi list
	nmcli device wifi connect "name" password "pw"
	nmcli connection show
	nmcli device
	ping archlinux.org
sudo timedatectl set-timezone America/Los_Angeles
sudo timedatectl set-ntp true
sudo timedatectl status
sudo pacman -Syu
sudo pacman -S ufw htop gvfs sshfs base-devel man-pages man-db cifs-utils dosfstools ntfsprogs exfat-utils stow tree spotify-launcher # openssh
rm ~/.bashrc
cd ~/linux-config/config
stow -t ~/ --restow --dotfiles *
source ~/.bashrc
mkdir ~/linux-config/src
cd ~/linux-config/src
git clone https://aur.archlinux.org/google-chrome.git
cd google-chrome
makepkg -si
# sudo helix /etc/ssh/sshd.config
	# Port 7530
	# PermitRootLogin no
sudo ufw default deny incoming
sudo ufw default allow outgoing
# sudo ufw allow from 192.168.0.0/24 to any port 7530 proto tcp
sudo ufw enable
sudo systemctl enable --now ufw.service
sudo systemctl status ufw.service
sudo ufw status verbose
# sudo systemctl enable --now cups.service
# sudo systemctl enable --now sshd.service
# sudo systemctl enable --now bluetooth.service
sudo reboot now

archUp
