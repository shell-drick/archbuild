#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="archlinux-baseline"
iso_label="ARCH_$(date +%Y%m)"
iso_publisher="Arch Linux <https://www.archlinux.org>"
iso_application="Arch Linux baseline"
iso_version="$(date +%Y.%m.%d)"
install_dir="arch"
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
file_permissions=(["/usr/bin/polybar"]="1000:1000:755" ["/usr/bin/polybar-msg"]="1000:1000:755" ["/usr/bin/st"]="1000:1000:755")
