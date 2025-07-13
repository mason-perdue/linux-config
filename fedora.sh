
### Fedora 42 Notes

## WSL:
wsl --install FedoraLinux-42
  # enter username
dnf check-update
dnf list --upgrades
sudo dnf upgrade -y
sudo dnf clean all
sudo dnf autoremove -y
# dnf list --installed installed
# dnf search [package]
# dnf info [package]
winget install --interactive --exact dorssel.usbipd-win Microsoft.Edit
# open wsl window
# open admin powershell
  usbipd bind --busid [busid]
usbipd.exe attach --wsl --busid [busid]
# usbipd.exe detach --busid [busid]
lsusb # or lsblk
mediawriter
sudo dnf install sane-backends mediawriter perl-Image-ExifTool ruff openssl ncurses texlive-scheme-full

## Workstation:


## Server:
sudo dd bs=4M if=Fedora-Server-netinst-x86_64-42-1.1.iso of=/dev/sdd conv=fsync oflag=direct status=progress
# Storage > Auto + Free Up Space + No Encryption
# No Root Login

