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
* Inherit current working directory
* DNS Resolver
* Mount Windows drives
* wslpath command

## Not working
* Inherit Windows PATH and WSL environment variable
* Linux Files inside of File Explorer(/etc and /usr/bin)
