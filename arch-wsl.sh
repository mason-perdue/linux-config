## Install
wsl.exe --list --online
wsl.exe --install archlinux
wsl.exe --list --verbose
wsl.exe --update
wsl.exe
passwd  # enter password
ping archlinux.org
ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime
timedatectl set-timezone America/Los_Angeles
timedatectl set-ntp true
timedatectl status
pacman -S ruff bash-language-server texlab stow helix sudo mesa vulkan-dzn vulkan-icd-loader usbutils sudo rsync reflector git htop man-pages man-db tree texlive evince openssh sane imagemagick perl-image-exiftool
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist
helix /etc/locale.gen
    # uncomment "en_US.UTF-8 UTF-8"
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
useradd -m masonp
passwd masonp
pacman -Syu
helix /etc/wsl.conf
    # [user]
    # default="user"
EDITOR=helix visudo
exit
wsl.exe --shutdown

## USBIPD
usdbipd.exe list
# on admin pwsh usbipd bind --busid [busid]
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
pacman -S [package]
pacman -Runs [package]
pacman -Syu
pacman -{Q,S}{s,i} [package]
pacman -Qet
pacman -Scc
