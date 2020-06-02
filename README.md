# ArchWSL2
Customized Arch Linux for WSL2

This is now developing and testing. For debug purposes only.

[Download](https://github.com/yuk7/ArchWSL2/releases/latest)

## What is this
This runs Customized Arch Linux in WSL2.
includes systemd support by default.

Please note that this distribution only works with WSL2.

## Working
* systemd/systemctl
* Run any commands and arguments from Windows (Arch2.exe, bash.exe, wsl.exe)
* Select User from Windows command(Arch2.exe, wsl.exe)
* Inherit current working directory and PATH
* DNS Resolver
* Mount Windows drives
* wslpath command
* Execute .exe onmounted Windows drive(e.g. /mnt/c)
* VS Code Remote Development

## Not working
* Execute .exe on Linux directory (e.g. /etc /root /home)
