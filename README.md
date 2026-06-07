## Packages

- This is where the official RengeOS packages are located

## How to use:

**1**. Add this mirror to /etc/pacman.conf:
  
```sh
[rengeos-official]
SigLevel = Optional TrustAll
Server = https://rengeos.github.io/packages/x86_64
```
**2**. Sync pacman:
```sh
pacman -Sy
```
